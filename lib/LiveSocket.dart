import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const LiveSocket());

class LiveSocket extends StatelessWidget {
  const LiveSocket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _authTokenController = TextEditingController();
  String errorMessage = '';
  String authToken = ''; // 定义 authToken 变量

  Future<bool> getPermissions() async {
    if (Platform.isIOS) return true;
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothConnect.request();

    while ((await Permission.camera.isDenied)) {
      await Permission.camera.request();
    }
    while ((await Permission.microphone.isDenied)) {
      await Permission.microphone.request();
    }
    while ((await Permission.bluetoothConnect.isDenied)) {
      await Permission.bluetoothConnect.request();
    }
    return true;
  }

  void checkAuthToken() async {
    String enteredAuthToken = _authTokenController.text;
    if (enteredAuthToken.isNotEmpty) {
      authToken = enteredAuthToken; // 将输入框的值赋给 authToken
      await getPermissions();
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (_) => MeetingPage(authToken: authToken)), // 传递 authToken
      );
    } else {
      setState(() {
        errorMessage = '你的房间号输入错误';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextField(
                  controller: _authTokenController,
                  decoration: InputDecoration(
                    hintText: '小朋友请输入房间号',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: checkAuthToken,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text('进入直播'),
                ),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeetingPage extends StatefulWidget {
  final String authToken;

  const MeetingPage({super.key, required this.authToken});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage>
    implements HMSUpdateListener {
  late HMSSDK hmsSDK;

  String userName = "test_user";

  HMSPeer? localPeer, remotePeer;
  HMSVideoTrack? localPeerVideoTrack, remotePeerVideoTrack;

  @override
  void initState() {
    super.initState();
    initHMSSDK();
  }

  void initHMSSDK() async {
    hmsSDK = HMSSDK();
    await hmsSDK.build();
    hmsSDK.addUpdateListener(listener: this);
    joinMeeting();
  }

  void joinMeeting() async {
    HMSConfig roomConfig = HMSConfig(
        authToken: widget.authToken, userName: userName); // 使用传递过来的 authToken
    hmsSDK.join(config: roomConfig);
  }

  @override
  void dispose() {
    remotePeer = null;
    remotePeerVideoTrack = null;
    localPeer = null;
    localPeerVideoTrack = null;
    super.dispose();
  }

  @override
  void onJoin({required HMSRoom room}) {
    room.peers?.forEach((peer) {
      if (peer.isLocal) {
        localPeer = peer;
        if (peer.videoTrack != null) {
          localPeerVideoTrack = peer.videoTrack;
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void onPeerUpdate({required HMSPeer peer, required HMSPeerUpdate update}) {
    switch (update) {
      case HMSPeerUpdate.peerJoined:
        if (!peer.isLocal) {
          if (mounted) {
            setState(() {
              remotePeer = peer;
            });
          }
        }
        break;
      case HMSPeerUpdate.peerLeft:
        if (!peer.isLocal) {
          if (mounted) {
            setState(() {
              remotePeer = null;
            });
          }
        }
        break;
      case HMSPeerUpdate.networkQualityUpdated:
        return;
      default:
        if (mounted) {
          setState(() {
            localPeer = null;
          });
        }
    }
  }

  @override
  void onTrackUpdate(
      {required HMSTrack track,
      required HMSTrackUpdate trackUpdate,
      required HMSPeer peer}) {
    if (track.kind == HMSTrackKind.kHMSTrackKindVideo) {
      switch (trackUpdate) {
        case HMSTrackUpdate.trackRemoved:
          if (mounted) {
            setState(() {
              peer.isLocal
                  ? localPeerVideoTrack = null
                  : remotePeerVideoTrack = null;
            });
          }
          return;
        default:
          if (mounted) {
            setState(() {
              peer.isLocal
                  ? localPeerVideoTrack = track as HMSVideoTrack
                  : remotePeerVideoTrack = track as HMSVideoTrack;
            });
          }
      }
    }
  }

  @override
  void onPeerListUpdate(
      {required List<HMSPeer> addedPeers,
      required List<HMSPeer> removedPeers}) {
    // 在这里实现你的逻辑，例如更新UI
  }

  @override
  void onAudioDeviceChanged(
      {HMSAudioDevice? currentAudioDevice,
      List<HMSAudioDevice>? availableAudioDevice}) {}

  @override
  void onSessionStoreAvailable({HMSSessionStore? hmsSessionStore}) {}

  @override
  void onChangeTrackStateRequest(
      {required HMSTrackChangeRequest hmsTrackChangeRequest}) {}

  @override
  void onHMSError({required HMSException error}) {}

  @override
  void onMessage({required HMSMessage message}) {}

  @override
  void onReconnected() {}

  @override
  void onReconnecting() {}

  @override
  void onRemovedFromRoom(
      {required HMSPeerRemovedFromPeer hmsPeerRemovedFromPeer}) {}

  @override
  void onRoleChangeRequest({required HMSRoleChangeRequest roleChangeRequest}) {}

  @override
  void onRoomUpdate({required HMSRoom room, required HMSRoomUpdate update}) {}

  @override
  void onUpdateSpeakers({required List<HMSSpeaker> updateSpeakers}) {}

  Widget peerTile(Key key, HMSVideoTrack? videoTrack, HMSPeer? peer) {
    return Container(
      key: key,
      child: (videoTrack != null && !(videoTrack.isMute))
          ? HMSVideoView(
              track: videoTrack,
            )
          : Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(4),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 20.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Text(
                  peer?.name.substring(0, 1) ?? "D",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        hmsSDK.leave();
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: (remotePeerVideoTrack == null)
                          ? MediaQuery.of(context).size.height
                          : MediaQuery.of(context).size.height / 2,
                      crossAxisCount: 1),
                  children: [
                    if (remotePeerVideoTrack != null && remotePeer != null)
                      peerTile(
                          Key(remotePeerVideoTrack?.trackId ?? "" "mainVideo"),
                          remotePeerVideoTrack,
                          remotePeer),
                    peerTile(
                        Key(localPeerVideoTrack?.trackId ?? "" "mainVideo"),
                        localPeerVideoTrack,
                        localPeer)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RawMaterialButton(
                  onPressed: () {
                    hmsSDK.leave();
                    Navigator.pop(context);
                  },
                  elevation: 2.0,
                  fillColor: Colors.red,
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.call_end,
                    size: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

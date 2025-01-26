import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class BlindBox extends StatefulWidget {
  @override
  _BlindBoxState createState() => _BlindBoxState();
}

class _BlindBoxState extends State<BlindBox> {
  final List<String> _images = [
    'assets/images/blindbox1.png',
    'assets/images/blindbox2.png',
    'assets/images/blindbox3.png',
  ];
  final List<int> _currentImageIndexes = List<int>.filled(8, 0);
  final List<String> _finalTexts = [
    '什么都没有',
    '放假作业＋1',
    '蹲马步',
    '背诵一首诗',
    '做深蹲',
    '一袋零食',
    '什么都没有',
    '什么都没有',
  ];
  final List<String> _alternateFinalTexts = [
    '什么都没有',
    '放假作业＋1',
    '蹲马步',
    '背诵一首诗',
    '做深蹲',
    '一袋零食',
    '什么都没有',
    '什么都没有',
  ];
  final List<String> _audioFiles = [
    'sounds/lazysheep1.wav',
    'sounds/lazysheep2.wav',
    'sounds/lazysheepdunmabu.wav',
    'sounds/lazysheeppoem.wav',
    'sounds/lazysheepshendun.wav',
    'sounds/lazysheepfood.wav',
    'sounds/lazysheepfood2.wav',
    'sounds/lazysheepfood2.wav',
  ];
  bool _useAlternateTexts = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onImageTap(int index) {
    _startImageSequence(index);
  }

  void _startImageSequence(int index) async {
    for (int i = 0; i < _images.length; i++) {
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        _currentImageIndexes[index] = i;
      });

      if (i == _images.length - 1) {
        _playAudio(index);
      }
    }
  }

  void _playAudio(int index) {
    _audioPlayer.play(AssetSource(_audioFiles[index]));
  }

  void _refreshImages() {
    setState(() {
      _useAlternateTexts = !_useAlternateTexts;
      for (int i = 0; i < _currentImageIndexes.length; i++) {
        _currentImageIndexes[i] = 0;
      }
    });
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OrientationBuilder(
            builder: (context, orientation) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/lazysheep.jpg'),
                  fit: BoxFit.cover,
                )),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onImageTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              child: Image.asset(
                                _images[_currentImageIndexes[index]],
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (_currentImageIndexes[index] ==
                                _images.length - 1)
                              Center(
                                child: Text(
                                  _useAlternateTexts
                                      ? _alternateFinalTexts[index]
                                      : _finalTexts[index],
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 240, 169, 169),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refreshImages,
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/lazysheep1.png',
                width: 120,
                height: 120,
              ))
        ],
      ),
    );
  }
}

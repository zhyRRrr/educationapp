import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import '../model/VideoModel.dart';
import '../model/WeiBoDetail.dart';

import '../pages/mine/personinfo_page.dart';
import '../public.dart';

var personMyFollowHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return FollowPage();
});

var personinfoHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  String userid = params["userid"]?.first;

  return new PersonInfoPage(userid);
});

var videoetailHandler = new Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  VideoModel mVideo =
      VideoModel.fromJson(convert.jsonDecode(params['video'][0]));
  return VideoDetailPage(mVideo);
});

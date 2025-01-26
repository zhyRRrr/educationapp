import '../constant/constant.dart';

class ServiceUrl {
  // 请求成功
  static const API_CODE_SUCCESS = "200";
// 1
// http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/list.do
  static String getVedioCategory =
      Constant.baseUrl + 'manage/hrlvedio/list.do'; // 获取视频分类

// http://175.27.193.33:8080/hrlweibo/manage/hrluser/get_user_info.do
  static String getUserInfo =
      Constant.baseUrl + 'manage/hrluser/get_user_info.do'; // 获取个人用户信息
// http://192.168.1.4:8082/hrlweibo/manage/hrlvedio/recommendlist.do
// http://192.168.1.4:8080/api/videos
// http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/recommendlist.do
  static String getVideoRecommendList =
      'http://192.168.1.4:8086/api/videos'; //视频-推荐列表

// http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/hotlist.do
  static String getVideoHotList =
      'http://192.168.1.4:8086/api/hotvideos'; //视频-热门列表

// http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/hotbannerad.do//视频-热门banner广告
  static String getVideoHotBannerAdList =
      'http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/hotbannerad.do'; //视频-热门banner广告

// http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/smallVideolist.do
  static String getVideoSmallList =
      Constant.baseUrl + 'manage/hrlvedio/smallVideolist.do'; //视频-小视频列表

// http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/videodetailrecommedlist.do
  static String getVideoDetailRecommendList =
      'http://175.27.193.33:8080/hrlweibo/manage/hrlvedio/videodetailrecommedlist.do'; //视频详情-推荐列表
}

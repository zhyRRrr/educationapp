import 'package:dio/dio.dart';
import 'dart:convert';
import '../public.dart';

class DioManager {
  static late final DioManager instance = DioManager._internal();

  factory DioManager() => instance;

  static late Dio dio;

  DioManager._internal() {
    var options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json', // 添加这一行
      },
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> post(String url, params,
      [Function? successCallBack, Function? errorCallBack]) async {
    Response? response;
    try {
      response = await dio.post(url, data: params);
    } catch (error) {
      print('请求异常: ' + error.toString());
      if (errorCallBack != null) {
        errorCallBack(error.toString());
      } else {
        return {};
      }
    }
    print('请求url: ' + url);
    print('返回参数: ' + response.toString());
    if (response?.statusCode == 200) {
      Map<String, dynamic> dataMap = json.decode(json.encode(response?.data));
      if (dataMap['status'] == 200) {
        if (successCallBack != null) {
          successCallBack(dataMap['data']);
        } else {
          return dataMap['data'];
        }
      } else {
        if (errorCallBack != null) {
          errorCallBack(dataMap['msg']);
        } else {
          return {};
        }
      }
    } else {
      if (errorCallBack != null) {
        errorCallBack(response.toString());
      } else {
        return {};
      }
    }
    return {};
  }

  Future<Map<String, dynamic>> get(String url,
      [Map<String, dynamic>? params]) async {
    Response? response;
    try {
      // 定义请求头
      Options options = Options(
        headers: {
          'Content-Type': 'application/json', // 添加请求头
        },
      );

      // 发起GET请求并传递查询参数
      response = await dio.get(url, queryParameters: params, options: options);
    } catch (error) {
      print('请求异常: ' + error.toString());
      return {}; // 返回一个空的Map
    }
    print('请求url: ' + url);
    print('返回参数: ' + response.toString());

    if (response?.statusCode == 200) {
      Map<String, dynamic> dataMap = json.decode(json.encode(response?.data));
      if (dataMap['status'] == 200) {
        return dataMap['data'];
      } else {
        print('错误消息: ${dataMap['msg']}');
        return {};
      }
    } else {
      print('HTTP错误: ${response?.statusCode}');
      return {};
    }
  }
}

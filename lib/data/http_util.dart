import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroidflutter/constant/api.dart';
import 'package:wanandroidflutter/util/log_util.dart';

/*
通用格式
{
    "data":{},
    "errorCode":0,
    "errorMsg":""
}
* */

HttpUtils httpUtils = HttpUtils();

///http请求封装
class HttpUtils {
  HttpUtils._internal() {
    if (null == _dio) {
      _dio = Dio();
      //dio 也是单例,设置baseUrl等一些配置
      _dio.options.baseUrl = Api.BASE_URL;
      _dio.options.connectTimeout = 30 * 1000;
      _dio.options.sendTimeout = 30 * 1000;
      _dio.options.receiveTimeout = 30 * 1000;
    }
  }

  static HttpUtils _singleton = HttpUtils._internal();

  factory HttpUtils() => _singleton;

  Dio _dio;

  Future get(String url, {Map<String, dynamic> params, BuildContext buildContext}) async {
    Response response;

    //path_provider 负责查找 iOS/Android 的目录文件，IO 模块负责对文件进行读写。  获取文档目录的路径
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    //新建目录
    var dir = Directory("$documentsPath/cookies");
    await dir.create();

    //LogUtil.d("文档目录path = ${documentsPath}");

    //添加cookie
    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path, ignoreExpires: true)));

    try {
      if (params != null) {
        response = await _dio.get(url, queryParameters: params);
      } else {
        response = await _dio.get(url);
      }

      if (response.data['errorCode'] == 0) {
        //这里直接把data部分给搞出来,免得每次在外面去解析˛
        return response.data['data'];
      } else {
        String data = response.data["errorMsg"];
        //ToolUtils.showToast(msg: data);
        LogUtil.d("请求网络错误 : $data");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        LogUtil.d(e.response.headers.toString());
        LogUtil.d(e.response.request.toString());
      } else {
        LogUtil.d(e.request.toString());
      }

      //ToolUtils.showToast(msg: handleError(e));
      //disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }

  ///post请求
  ///url : 地址
  ///formData : 请求参数
  Future post(String url,
      {FormData formData,
      Map<String, dynamic> queryParameters,
      bool isAddLoading = false,
      BuildContext context,
      String loadingText}) async {
    Response response;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = Directory("$documentsPath/cookies");
    await dir.create();

    //cookie
    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    //loading
    if (isAddLoading) {
      showLoading(context, loadingText);
    }

    try {
      if (formData != null) {
        response = await _dio.post(url, data: formData);
      } else if (queryParameters != null) {
        response = await _dio.post(url, queryParameters: queryParameters);
      } else {
        response = await _dio.post(url);
      }

      //隐藏loading
      disMissLoadingDialog(isAddLoading, context);

      //json 数据
      LogUtil.d(response.toString());

      if (response.data['errorCode'] == 0) {
        //这里直接把data部分给搞出来,免得每次在外面去解析˛
        return response.data['data'];
      } else {
        String data = response.data["errorMsg"];
        //ToolUtils.showToast(msg: data);
        LogUtil.d("请求网络错误 : $data");
      }

    } on DioError catch (e) {
      if (e.response != null) {
        LogUtil.d(e.response.headers.toString());
        LogUtil.d(e.response.request.toString());
      } else {
        LogUtil.d(e.request.toString());
      }

      //ToolUtils.showToast(msg: handleError(e));
      //disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }

  void showLoading(BuildContext context, String loadingText) {}

  void disMissLoadingDialog(bool isAddLoading, BuildContext context) {}
}

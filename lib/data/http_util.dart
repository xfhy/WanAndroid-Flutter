import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroidflutter/util/log_util.dart';

/*
通用格式
{
    "data":{},
    "errorCode":0,
    "errorMsg":""
}
* */

///http请求封装
class HttpUtils {
  Future get(String url,
      {Map<String, dynamic> params, BuildContext buildContext}) async {
    Response response;

    //path_provider 负责查找 iOS/Android 的目录文件，IO 模块负责对文件进行读写。  获取文档目录的路径
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    //新建目录
    var dir = Directory("$documentsPath/cookies");
    await dir.create();

    LogUtil.d("文档目录path = ${documentsPath}");

    Dio dio = Dio();

    //添加cookie
    dio.interceptors.add(
        CookieManager(PersistCookieJar(dir: dir.path, ignoreExpires: true)));

    try {
      if (params != null) {
        response = await dio.get(url, queryParameters: params);
      } else {
        response = await dio.get(url);
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
}

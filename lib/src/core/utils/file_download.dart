import 'package:dio/dio.dart';
import 'package:download/download.dart';
import 'package:flutter/material.dart';

class FileDownload {
  static Future<bool> downloadFile(String url, String fileName) async {
    debugPrint("Download: $url");
    Response response;
    var dio = Dio();
    try {
      response = await dio.get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            headers: {
              'Access-Control-Allow-Headers': '*',
              'Access-Control-Allow-Origin': '*'
            }),
      );

      final stream = Stream.fromIterable(response.data.toString().codeUnits);
      download(stream, fileName);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

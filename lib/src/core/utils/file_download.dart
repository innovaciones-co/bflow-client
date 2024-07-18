import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

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

      final base64 = base64Encode(response.data);

      final anchor = html.AnchorElement(
          href: 'data:application/octet-stream;base64,$base64')
        ..target = 'blank';
      anchor.download = fileName;
      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

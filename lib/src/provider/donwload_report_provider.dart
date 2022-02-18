import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DonwloadReport extends ChangeNotifier {
  String baseUrl =
      'https://cruz-roja-inventory.herokuapp.com/api/reporte/search/pdf/';
  final _storage = FlutterSecureStorage();
  String? token;

  Future openFile({required String url, String? filename}) async {
    token = await _storage.read(key: 'id_token');
    baseUrl = '$baseUrl${url}';
    final name = filename ?? url.split('').last;

    final file = await downloadFile(baseUrl, name);
    //print(file);
    if (file == null) return;

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
            headers: {'x-token': '$token'}),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      print('Si estoy funcionando finalmente');
      await raf.close();
      return file;
    } catch (error) {
      print("algo paso $error");
      return null;
    }
  }
}

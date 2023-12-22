import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class Downloader {
  static Future<File?> downloadImageUrl(
      {required String urlPath, String name = ''}) async {
    String nameFile = name;
    if (urlPath.isEmpty) {
      return null;
    }
    if (nameFile.isEmpty) {
      nameFile = DateTime.now().microsecond.toString();
    }
    final url = Uri.parse(urlPath);
    final response = await get(url);
    final documentDirectory = await getApplicationDocumentsDirectory();
    final firstPath = '${documentDirectory.path}/images';
    final filePathAndName = '${documentDirectory.path}/images/$nameFile.jpg';
    await Directory(firstPath).create(recursive: true);
    final file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
    return file2;
  }
}

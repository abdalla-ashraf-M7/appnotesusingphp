// ignore_for_file: empty_catches, depend_on_referenced_packages

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('abdalla:abdalla123'));
Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getRequest(String link) async {
    try {
      var response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode} ");
      }
    } catch (e) {
      print(e);
    }
  }

  postRequest(String link, Map data) async {
    try {
      var response = await http.post(Uri.parse(link), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error ${response.statusCode} ");
      }
    } catch (e) {
      print(e);
    }
  }

  postRequestWithFile(String link, Map data, File file) async {
    try {
      var request = http.MultipartRequest("post", Uri.parse(link));
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multipartFile = http.MultipartFile("file", stream, length, filename: basename(file.path));
      request.headers.addAll(myheaders);
      request.files.add(multipartFile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);

      if (myrequest.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("error ${myrequest.statusCode}");
      }
    } catch (e) {}
  }
}

// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {
  GetRequset(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("Here ///////////////////////");
        var responsbody = jsonDecode(response.body);
        return responsbody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch ${e}");
    }
  }

  PostRequset(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      print(response.body);
      if (response.statusCode == 200) {
        var responsbody = jsonDecode(response.body);
        return responsbody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch ${e}");
    }
  }

  PostRequsetWithFile(String url, Map data, File file) async {
    try {
      var request = await http.MultipartRequest("POST", Uri.parse(url));
      var lenght = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multipartfile = http.MultipartFile("file", stream, lenght,
          filename: basename(file.path));
      request.files.add(multipartfile);
      request.fields['t_id'] = data['t_id'];
      request.fields['imageUrl'] = data['imageUrl'];
      var Myrequest = await request.send();
      var response = await http.Response.fromStream(Myrequest);
      if (response.statusCode == 200) {
        var responsbody = jsonDecode(response.body);
        print("............." + responsbody);
        return responsbody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch ${e}");
    }
  }
}

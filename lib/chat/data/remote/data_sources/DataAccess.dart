import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class DataAccessCrud {
  GetRequset(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
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

  PostRequset(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
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
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var Myrequest = await request.send();
      var response = await http.Response.fromStream(Myrequest);
      if (response.statusCode == 200) {
        var responsbody = jsonDecode(response.body);
        // print("............." + responsbody);
        return responsbody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch ${e}");
    }
  }

  Future<bool> checkServerConnection() async {
    try {
      // var client = http.Client();
      // var timeout = Duration(milliseconds: 250);
      // var response =
      //     await client.get(Uri.parse(linkConectedServer)).timeout(timeout);
      // if (response.statusCode == 200) {
      //   var response = await http.get(Uri.parse(linkConectedServer));
      //   var responseBody = jsonDecode(response.body);
      //   if (responseBody["status"] == "success") {
      //     // print("checkServerConnection: true   '${responseBody["status"]}'");
      //     return true;
      //   }
      //   print("checkServerConnection: false   '${responseBody["status"]}'");
      //   return false;
      // } else {
      //   return false;
      // }
      return false;
    } catch (e) {
      print("catch no connect");
      return false;
    }
  }
}

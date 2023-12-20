import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/forumModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForumController{
  Future get(String courseSlug) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');
    String url = SERVER_API+"course/"+courseSlug+"/forum";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':'Bearer ${jwt}'
        },
      );
      Map<String, dynamic> res = jsonDecode(response.body);
      List<ForumModel> forums = [];
      res['data'].forEach((data) {
        forums.add(ForumModel.fromJson(data));
      });
      return forums;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future addNewForum(String courseSlug,String message, String materialSlug) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');
    String url = SERVER_API+"course/"+courseSlug+"/forum";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':'Bearer ${jwt}'
        },
        body: {
          "message":message,
        }
      );
      Map<String, dynamic> res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
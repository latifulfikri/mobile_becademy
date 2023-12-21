import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/accountModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountController {
  Future updateProfile(String name, String gender, String degree, String school, String fieldOfStudy, String title, String company, String location) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');
    String url = SERVER_API+"my/data/update";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization':'Bearer ${jwt}'
        },
        body: {
          "name":name,
          "gender":gender,
          "degree":degree,
          "school":school,
          "field_of_study":fieldOfStudy,
          "title": title,
          "company": company,
          "location": location
        }
      );
      Map<String, dynamic> res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future getProfileDetail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');

    await http.get(
      Uri.parse(SERVER_API+"my/data"),
      headers: {
        'Authorization':'Bearer ${jwt}'
      }
    ).then((value) {
      Map<String,dynamic> responseBody = jsonDecode(value.body);
      if (value.statusCode == 200) {
        AccountModel account = AccountModel.fromJson(responseBody['data']);
        return account;
      }
    });
  }
}
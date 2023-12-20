import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MemberController {
  Future get(String memberId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');
    String url = SERVER_API+"my/invoice/"+memberId;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':'Bearer ${jwt}'
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
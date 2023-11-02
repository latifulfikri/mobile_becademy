import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/moduleModel.dart';
import 'package:http/http.dart' as http;

class ModuleController{
  Future get(String courseSlug) async {
    String url = SERVER_API+"course/"+courseSlug+"/module";
    try {
      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<ModuleModel> modules = [];
        res['data'].forEach((module){
          modules.add(ModuleModel.fromJson(module));
        });
        return modules;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
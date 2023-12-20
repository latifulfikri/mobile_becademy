import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController {
  Future get() async {
    try {
      final response = await http.get(Uri.parse(SERVER_API+"category"));
      if (response.statusCode == 200) {
        Map<String,dynamic> category = jsonDecode(response.body);
        // List<CategoryModel> categories = category.map((data) => CategoryModel.fromJson(data)).toList();
        List<CategoryModel> categories = [];
        category['data'].forEach((data) {
          categories.add(CategoryModel.fromJson(data));
        });
        return categories;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMy() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');

    try {
      final url = SERVER_API+"my/category";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':'Bearer ${jwt}'
        }
      );
      if (response.statusCode == 200) {
        Map<String,dynamic> category = jsonDecode(response.body);
        List<CategoryModel> categories = [];
        category['data'].forEach((data) {
          categories.add(CategoryModel.fromJsonUser(data));
        });
        return categories;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future addUserCategoryJourney(String category_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');

    try {
      final url = SERVER_API+"my/journey/category/"+category_id;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':'Bearer ${jwt}'
        }
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
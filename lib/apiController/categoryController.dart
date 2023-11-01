import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:http/http.dart' as http;

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
}
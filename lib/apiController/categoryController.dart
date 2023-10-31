import 'dart:convert';

import 'package:becademy/model/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  final baseApiUrl = "https://becademy.fikriyuwi.com/api/";

  Future get() async {
    try {
      final response = await http.get(Uri.parse(baseApiUrl+"category"));
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
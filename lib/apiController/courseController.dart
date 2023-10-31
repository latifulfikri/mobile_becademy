import 'dart:convert';

import 'package:becademy/apiController/categoryController.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseController {
  final baseApiUrl = "https://becademy.fikriyuwi.com/api/";
  Future get() async {
    try {
      final response = await http.get(Uri.parse(baseApiUrl+"course"));
      if (response.statusCode == 200) {
        Map<String,dynamic> course = jsonDecode(response.body);
        // Iterable courseData = jsonDecode(course['data']);
        // final courseData = course['data'];
        // List<CourseModel> courses = courseData.map((data) => CourseModel.fromJson(data)).toList();
        List<CourseModel> courses = [];
        course['data'].forEach((data){
          courses.add(CourseModel.fromJson(data));
        });
        return courses;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
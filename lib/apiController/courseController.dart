import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:http/http.dart' as http;

class CourseController {
  Future get() async {
    try {
      final response = await http.get(Uri.parse(SERVER_API+"course"));
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

  Future getCourse(String slug) async {
    try {
      final response = await http.get(Uri.parse(SERVER_API+"course/"+slug));
      Map<String,dynamic> res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print(e.toString());
    }
  }

}
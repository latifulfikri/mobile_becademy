import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CourseController {
  
  Future get() async {
    try {
      final response = await http.get(Uri.parse(SERVER_API+"course"));
      Map<String,dynamic> course = jsonDecode(response.body);
      if (response.statusCode == 200) {
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
      return [];
    }
  }

  Future getCourse(String slug) async {
    try {
      final response = await http.get(Uri.parse(SERVER_API+"course/"+slug));
      Map<String,dynamic> res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getMyCourse() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');

    try {
      final response = await http.get(
        Uri.parse(SERVER_API+"my/course"),
        headers: {
          'Authorization':'Bearer ${jwt}'
        }
      );
      Map<String,dynamic> res = jsonDecode(response.body);
      List<CourseModel> courses = [];
      res['data'].forEach((data) {
        courses.add(CourseModel.fromJsonMyCourse(data['course']));
      });
      return courses;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future isMember(String slug) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');

    try {
      final response = await http.put(
        Uri.parse(SERVER_API+"course/"+slug+"/is-member"),
        headers: {
          'Authorization':'Bearer ${jwt}'
        }
      );
      Map<String,dynamic> res = jsonDecode(response.body);
      return res['data']['result'];
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

}
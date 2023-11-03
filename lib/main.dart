import 'package:becademy/apiController/categoryController.dart';
import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/model/accountModel.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/router/go_router_provider.dart';
import 'package:becademy/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var SERVER_API = "https://becademy.fikriyuwi.com/api/";
int openApp = 0;
AccountModel? userLoginData;
List<CourseModel> coursesData = [];
List<CourseModel> myCoursesData = [];
List<CategoryModel> categoriesData = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp
      ]
    );
    return MaterialApp.router(
      title: 'Becademy',
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.goRouterProvider,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
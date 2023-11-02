import 'package:becademy/pages/auth/login.dart';
import 'package:becademy/pages/course/course.dart';
import 'package:becademy/pages/course/courseDetail.dart';
import 'package:becademy/pages/exception/emailVerificationSent.dart';
import 'package:becademy/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  
  AppNavigation._();

  static String initR = '/';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();


  static final GoRouter goRouterProvider = GoRouter(
    // redirect: (context, state) {
    //   var currentPage = state.uri.toString();

    //   if (userLoginData != null && currentPage == '/login') {
    //     return '/';
    //   }
    //   if (userLoginData == null && currentPage != '/login') {
    //     return '/login';
    //   }
    //   return null;
    // },
    navigatorKey: _rootNavigatorKey,
    initialLocation: initR,
    routes: <RouteBase>[
      GoRoute(
        path: "/exception/emailNotVerified",
        name: "exception.emailNotVerified",
        builder: (context, state) => EmailVerificationSent(message: "Apa"),
      ),
      GoRoute(
        path: "/exception/email/sent:message",
        name: "exception.verified",
        builder: (context, state) => EmailVerificationSent(message: state.pathParameters['courseSlug']!),
      ),
      GoRoute(
        path: "/",
        name: "main",
        builder:(context, state) => MainPage(),
      ),
      GoRoute(
        path: "/login",
        name: "login",
        builder:(context, state) => LoginPage(),
      ),
      GoRoute(
        path: "/course",
        name: "course",
        builder: (context, state) => CoursePage(),
        routes: [
          GoRoute(
            path: ":courseSlug",
            name: "course.detail",
            builder: (context, state) =>
              CourseDetailPage(courseSlug: state.pathParameters['courseSlug']!)
          )
        ]
      ),
    ]
  );
}
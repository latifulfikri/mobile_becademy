import 'package:becademy/pages/auth/login.dart';
import 'package:becademy/pages/main/course.dart';
import 'package:becademy/pages/main/home.dart';
import 'package:becademy/pages/main/notification.dart';
import 'package:becademy/pages/main/profile.dart';
import 'package:becademy/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final _rootNavigatorCourse = GlobalKey<NavigatorState>(debugLabel: 'shellCourse');
  static final _rootNavigatorNotification = GlobalKey<NavigatorState>(debugLabel: 'shellNotification');
  static final _rootNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  static final GoRouter goRouterProvider = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: initR,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context,state,body) {
          return MainPage(body: body);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: "/",
                name: "home",
                builder: (context,state) {
                  return MainHomePage(
                    key: state.pageKey,
                  );
                }
              ),
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorCourse,
            routes: [
              GoRoute(
                path: "/course",
                name: "course",
                builder: (context,state) {
                  return MainCoursePage(
                    key: state.pageKey,
                  );
                }
              ),
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorNotification,
            routes: [
              GoRoute(
                path: "/notification",
                name: "notification",
                builder: (context,state) {
                  return MainNotificationPage(
                    key: state.pageKey,
                  );
                }
              ),
            ]
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorProfile,
            routes: [
              GoRoute(
                path: "/profile",
                name: "profile",
                builder: (context,state) {
                  return MainProfilePage(
                    key: state.pageKey,
                  );
                }
              ),
            ]
          )
        ]
      )
    ]
  );
}
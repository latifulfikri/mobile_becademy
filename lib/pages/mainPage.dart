import 'dart:ui';

import 'package:becademy/pages/main/course.dart';
import 'package:becademy/pages/main/home.dart';
import 'package:becademy/pages/main/notification.dart';
import 'package:becademy/pages/main/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.body});
  final StatefulNavigationShell body;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> { 
  int _bottomNavigationCurrentIndex = 0;

  final List<IconData> _bottomNavItem = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.solidBell,
    FontAwesomeIcons.solidUser,
  ];

  List<String> _title = [
    "Hi, Nick!",
    "Kelasku",
    "Notifikasi",
    "Profil"
  ];

  void _goToBranch(int index)
  {
    widget.body.goBranch(
      index,
      initialLocation: index == widget.body.currentIndex
    );
  }

  // List<Widget> _container = [
  //   MainHomePage(),
  //   MainCoursePage(),
  //   MainNotificationPage(),
  //   MainProfilePage()
  // ];

  @override
  Widget build(BuildContext context) {
    var uri = GoRouter.of(context).routeInformationProvider.value.uri;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   flexibleSpace: ClipRect(
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(
      //         sigmaX: 20,
      //         sigmaY: 20,
      //       ),
      //       child: Container(
      //         color: Colors.transparent,
      //       ),
      //     ),
      //   ),
      //   elevation: 0,
      //   centerTitle: false,
      //   title: Text(
      //     " ${_title[_bottomNavigationCurrentIndex]}",
      //     style: TextStyle(
      //       fontWeight: FontWeight.w900
      //     ),
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () => {
      //         context.go("/login")
      //       },
      //       child: Container(
      //         margin: EdgeInsets.fromLTRB(0, 8, 20, 8),
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).colorScheme.primary,
      //           borderRadius: BorderRadius.circular(100)
      //         ),
      //         padding: EdgeInsets.symmetric(
      //           horizontal: 14,
      //           vertical: 8
      //         ),
      //         child: Icon(
      //           FontAwesomeIcons.solidUser,
      //           size: 16,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body:Stack(
        children: [
          widget.body,
          // bottom nav bar
          Column(
            children: [
              const Spacer(),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
              )
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                Spacer(),
                _bottomNavigationBar()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    Color iconColor = Theme.of(context).colorScheme.tertiary;
    Color iconColorActive = Theme.of(context).colorScheme.secondary;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 32,
        ),
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: const Offset(0, 0),
              blurRadius: 16,
              spreadRadius: 8,
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              _bottomNavItem.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _bottomNavigationCurrentIndex = index;
                  });
                  _goToBranch(_bottomNavigationCurrentIndex);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: _bottomNavigationCurrentIndex == index ? 24:0,
                      height: _bottomNavigationCurrentIndex == index ? 8:0,
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(
                      width: 32,
                      child: Icon(
                        _bottomNavItem[index],
                        // color: iconColor,
                        color: _bottomNavigationCurrentIndex == index ? iconColorActive : iconColor,
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: 24,
                      height: _bottomNavigationCurrentIndex == index ? 0:8,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                )
              )
            )
          ],
        ),
      )
    );
  }
}
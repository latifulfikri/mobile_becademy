import 'dart:ui';

import 'package:becademy/main.dart';
import 'package:becademy/pages/main/course.dart';
import 'package:becademy/pages/main/home.dart';
import 'package:becademy/pages/main/notification.dart';
import 'package:becademy/pages/main/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

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

  // void _goToBranch(int index)
  // {
  //   widget.body.goBranch(
  //     index,
  //     initialLocation: index == widget.body.currentIndex
  //   );
  // }

  Future getJwt() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');
    if (await jwt == null) {
      setState(() {
        userLogin.setData(false);
        context.go("/login");
      });
    }
  }

  @override
  void initState() {
    getJwt();
    // print(GoRouterState.of(context).uri.toString());
    // TODO: implement initState
    super.initState();
  }

  List<Widget> _container = [
    MainHomePage(),
    MainCoursePage(),
    MainNotificationPage(),
    MainProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          " ${_title[_bottomNavigationCurrentIndex]}",
          style: TextStyle(
            fontWeight: FontWeight.w900
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => {
              context.go("/login")
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 8, 20, 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(100)
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8
              ),
              child: Icon(
                FontAwesomeIcons.solidUser,
                size: 16,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body:Stack(
        children: [
          _container[_bottomNavigationCurrentIndex],
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
                _bottomNavigationBar(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(context) {
    String pageNow = GoRouterState.of(context).uri.toString();

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

            // GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         _bottomNavigationCurrentIndex = 0;
            //       });
            //       _goToBranch(_bottomNavigationCurrentIndex);
            //     },
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: pageNow == '/' ? 24:0,
            //           height: pageNow == '/' ? 8:0,
            //           margin: EdgeInsets.only(bottom: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Theme.of(context).colorScheme.secondary,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 32,
            //           child: Icon(
            //             _bottomNavItem[0],
            //             // color: iconColor,
            //             color: pageNow == '/' ? iconColorActive : iconColor,
            //           ),
            //         ),
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: 24,
            //           height: pageNow == '/' ? 0:8,
            //           margin: EdgeInsets.only(top: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.transparent,
            //           ),
            //         ),
            //       ],
            //     )
            //   ),
            //   GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         _bottomNavigationCurrentIndex = 1;
            //       });
            //       _goToBranch(_bottomNavigationCurrentIndex);
            //     },
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: pageNow == '/course' ? 24:0,
            //           height: pageNow == '/course' ? 8:0,
            //           margin: EdgeInsets.only(bottom: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Theme.of(context).colorScheme.secondary,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 32,
            //           child: Icon(
            //             _bottomNavItem[1],
            //             // color: iconColor,
            //             color: pageNow == '/course' ? iconColorActive : iconColor,
            //           ),
            //         ),
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: 24,
            //           height: pageNow == '/course' ? 0:8,
            //           margin: EdgeInsets.only(top: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.transparent,
            //           ),
            //         ),
            //       ],
            //     )
            //   ),
            //   GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         _bottomNavigationCurrentIndex = 2;
            //       });
            //       _goToBranch(_bottomNavigationCurrentIndex);
            //     },
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: pageNow == '/notification' ? 24:0,
            //           height: pageNow == '/notification' ? 8:0,
            //           margin: EdgeInsets.only(bottom: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Theme.of(context).colorScheme.secondary,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 32,
            //           child: Icon(
            //             _bottomNavItem[2],
            //             // color: iconColor,
            //             color: pageNow == '/notification' ? iconColorActive : iconColor,
            //           ),
            //         ),
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: 24,
            //           height: pageNow == '/notification' ? 0:8,
            //           margin: EdgeInsets.only(top: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.transparent,
            //           ),
            //         ),
            //       ],
            //     )
            //   ),
            //   GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         _bottomNavigationCurrentIndex = 3;
            //       });
            //       _goToBranch(_bottomNavigationCurrentIndex);
            //     },
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: pageNow == '/profile' ? 24:0,
            //           height: pageNow == '/profile' ? 8:0,
            //           margin: EdgeInsets.only(bottom: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Theme.of(context).colorScheme.secondary,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 32,
            //           child: Icon(
            //             _bottomNavItem[3],
            //             // color: iconColor,
            //             color: pageNow == '/profile' ? iconColorActive : iconColor,
            //           ),
            //         ),
            //         AnimatedContainer(
            //           duration: Duration(milliseconds: 200),
            //           width: 24,
            //           height: pageNow == '/profile' ? 0:8,
            //           margin: EdgeInsets.only(top: 8),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: Colors.transparent,
            //           ),
            //         ),
            //       ],
            //     )
            //   )
          ],
        ),
      )
    );
  }
}
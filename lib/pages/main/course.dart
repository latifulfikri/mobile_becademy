import 'dart:ui';

import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MainCoursePage extends StatefulWidget {
  const MainCoursePage({super.key});

  @override
  State<MainCoursePage> createState() => _MainCoursePageState();
}

class _MainCoursePageState extends State<MainCoursePage> {
  List<CourseModel> courses = [];
  CourseController courseApi = CourseController();

  Future<void> getCourses() async {
    courses.clear();
    courses = await courseApi.get();
    setState(() {
      
    });
  }

  @override
  void initState() {
    getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return new ListView(
    //   children: [
    //     Column(
    //       children: [
    //         courseItem("Dasar Pemrograman Menggunakan C", "CLI", 0.67),
    //         SizedBox(
    //           height: 16,
    //         ),
    //         courseItem("Dasar Database Menggunakan MySQL", "Database", 0.37),
    //         SizedBox(
    //           height: 16,
    //         ),
    //         courseItem("Membuat Landing Page", "Website", 0.13),
    //         SizedBox(
    //           height: 24,
    //         ),
    //         ElevatedButton(
    //           onPressed: (){},
    //           child: Wrap(
    //             crossAxisAlignment: WrapCrossAlignment.center,
    //             children: [
    //               Icon(FontAwesomeIcons.plus),
    //               SizedBox(width: 16,),
    //               Text("Daftar kelas baru")
    //             ],
    //           )
    //         )
    //       ],
    //     ),
    //     SizedBox(
    //       height: 120,
    //     )
    //   ]
    // );
    return iosWidget();
  }

  Widget liquidWidget()
  {
    return LiquidPullToRefresh(
      onRefresh: getCourses,
      height: 100,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Theme.of(context).primaryColor,
      animSpeedFactor: 2,
      borderWidth: 2,
      showChildOpacityTransition: true,
      child: ListView.separated(
        itemBuilder: (context,index) {
          return courseItem(courses[index]);
        },
        separatorBuilder: (context,index) {
          return const SizedBox(height: 0,);
        },
        itemCount: courses.length
      ),
    );
  }

  Widget iosWidget()
  {
    return new Container(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: getCourses,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context,index) {
                return courseItem(courses[index]);
              },
              childCount: courses.length > 3 ? 3 : courses.length
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () {
                            context.push("/course");
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text("Lihat semua course")
                            ],
                          )
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 160,
                )
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget courseItem(CourseModel course) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(24)
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(16)
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.name),
                  Padding(padding: EdgeInsets.only(bottom: 8)),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(
                          course.category.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${(0.67*100).toInt()}%")
                        ],
                      ),
                    )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 8)),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16)
                            ),
                            child: new FractionallySizedBox(
                              widthFactor: 0.67,
                              heightFactor: 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Text(""),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
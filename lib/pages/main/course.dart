import 'dart:ui';

import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    // print(courses[0].category.name);
    // TODO: implement initState
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
      height: MediaQuery.of(context).size.height/2,
      backgroundColor: Theme.of(context).primaryColor,
      color: Theme.of(context).scaffoldBackgroundColor,
      animSpeedFactor: 2,
      borderWidth: 2,
      child: ListView.separated(
        itemBuilder: (context,index) {
          return courseItem(courses[index]);
        },
        separatorBuilder: (context,index) {
          return const SizedBox(height: 16,);
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
          const SliverAppBar(
            pinned: false,
            floating: true,
            title: Padding(padding: EdgeInsets.all(16), child: Text("Kelasku", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),),),
            centerTitle: false,
            
            // flexibleSpace: ClipRect(
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(
            //       sigmaX: 20,
            //       sigmaY: 20,
            //     ),
            //     child: Container(
            //       color: Colors.transparent,
            //     ),
            //   ),
            // ),
            elevation: 0,
          ),
          CupertinoSliverRefreshControl(
            onRefresh: getCourses,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context,index) {
                return courseItem(courses[index]);
              },
              childCount: courses.length
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
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

  Widget androidWidget()
  {
    return new RefreshIndicator(
      onRefresh: getCourses,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return courseItem(courses[index]);
        },
        itemCount: courses.length,
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
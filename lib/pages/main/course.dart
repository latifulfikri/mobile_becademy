import 'dart:ui';

import 'package:becademy/apiController/categoryController.dart';
import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/model/categoryModel.dart';
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
  List<CategoryModel> categories = [];
  CategoryController categoryApi = CategoryController();
  
  List<CourseModel> allCourses = [];
  List<CourseModel> courses = [];
  CourseController courseApi = CourseController();

  Future<void> getCategories() async {
    categories.clear();
    categories = await categoryApi.get();
    setState(() {
      
    });
  }

  Future<void> getCourses() async {
    allCourses.clear();
    allCourses = await courseApi.getMyCourse();
    setState(() {
      courses = allCourses;
    });
  }

  void filterMyCourseByCategory(String keyword) {
    List<CourseModel> result = [];
    if (keyword == "all") {
      result.clear();
      result = allCourses;
    } else {
      result.clear();
      result = allCourses.where((element) => element.category_id!.contains(keyword)).toList();
    }
    setState(() {
      courses = result;
    });
  }

  void findCourses(String keyword) {
    List<CourseModel> result = [];
    if (keyword.isEmpty) {
      result.clear();
      result = allCourses;
    } else {
      result.clear();
      result = allCourses.where((element) =>
          element.name.toLowerCase().contains(keyword.toLowerCase())
      ).toList();
    }
    setState(() {
      courses = result;
    });
  }

  @override
  void initState() {
    getCategories();
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

  Widget categoryWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        filterMyCourseByCategory("all");
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.mobile),
                          Text(
                            "All",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ),
                  ),
                  ...List.generate(categories.length, (index){
                    return Container(
                      padding: EdgeInsets.only(right: 24),
                      child: ElevatedButton(
                        onPressed: () {
                          filterMyCourseByCategory(categories[index].id);
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.mobile),
                            Text(
                              categories[index].name,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget searchWidget() {
    return new Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 24
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(16)
            ),
            child: TextField(
              onTap: () {
                context.push('/course');
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(FontAwesomeIcons.magnifyingGlass),
                ),
                hintText: "Cari course disini",
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                )
              ),
            )
          ),
        )
      ],
    );
  }

  Widget courseItem(CourseModel course) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(24)
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
          ),
          onTap: () {
            context.push("/course/${course.slug}");
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
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
                              Text(
                                course.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 8)),
                              Text(
                                course.desc.length > 20 ? course.desc.substring(0,40)+"..." : course.desc,
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 8)),
                              courseDetail(16, 3)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget courseDetail(int module, int time)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(FontAwesomeIcons.solidBookmark,color: Theme.of(context).primaryColor),
              Padding(padding: EdgeInsets.only(right: 4)),
              Text("${module.toString()}"),
              Padding(padding: EdgeInsets.only(right: 16)),
              Icon(FontAwesomeIcons.solidClock,color: Theme.of(context).primaryColor,),
              Padding(padding: EdgeInsets.only(right: 4)),
              Text("${time.toString()}h"),
            ],
          ),
        )
      ],
    );
  }
}
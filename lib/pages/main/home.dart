import 'dart:ui';

import 'package:becademy/apiController/categoryController.dart';
import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/main.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  List<CategoryModel> categories = [];
  CategoryController categoryApi = CategoryController();
  List<CourseModel> allMyCourse = [];
  List<CourseModel> myCourse = [];
  CourseController courseApi = CourseController();

  Future<void> getCategories() async {
    categories.clear();
    categories = await categoryApi.get();
    setState(() {
      
    });
  }

  Future<void> getMyCourse() async {
    allMyCourse.clear();
    allMyCourse = await courseApi.getMyCourse();
    setState(() {
      myCourse = allMyCourse;
    });
  }

  void filterMyCourseByCategory(String keyword) {
    List<CourseModel> result = [];
    if (keyword == "all") {
      result.clear();
      result = allMyCourse;
    } else {
      result.clear();
      result = allMyCourse.where((element) => element.category_id!.contains(keyword)).toList();
    }
    setState(() {
      myCourse = result;
    });
  }

  void findCourses(String keyword) {
    List<CourseModel> result = [];
    if (keyword.isEmpty) {
      result.clear();
      result = allMyCourse;
    } else {
      result.clear();
      result = allMyCourse.where((element) =>
          element.name.toLowerCase().contains(keyword.toLowerCase())
      ).toList();
    }
    setState(() {
      myCourse = result;
    });
  }

  @override
  void initState() {
    getCategories();
    getMyCourse();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              getCategories();
              getMyCourse();
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                mainWidget(),
                categoryWidget(),
                searchWidget(),
                SizedBox(height: 24,),
                recomendationWidget(),
                SizedBox(
                  height: 160,
                )
              ]
            )
          )
        ],
      ),
    );
  }

  Widget mainWidget() {
    return new Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(24)
            ),
            margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dasar Pemrograman Menggunakan Bahasa C",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 24)),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "Selesaikan "),
                      TextSpan(
                        text: "Course 3",
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ]
                  )
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: "Sebelum "),
                      TextSpan(
                        text: "31 Aug 2023",
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ]
                  )
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push("/course");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.play),
                      SizedBox(width: 16,),
                      Text("Lanjut Belajar")
                    ],
                  )
                ),
              ]
            ),
          ),
        )
      ],
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
              onChanged: (value) => findCourses(value),
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

  Widget recomendationWidget() {
    if (myCourse.length > 0) {
      return new Row(
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                ...List.generate(myCourse.length, (index) => courseItem(myCourse[index]))
              ],
            ),
          )
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Kamu belum terdaftar\nke kelas manapun",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: () => context.push("/course"),
                    child: Text("Lihat semua kelas"),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
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
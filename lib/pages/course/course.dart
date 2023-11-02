import 'dart:ui';

import 'package:becademy/apiController/categoryController.dart';
import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {

  List<CategoryModel> categories = [];
  CategoryController categoryApi = CategoryController();

  Future<void> getCategories() async {
    categories.clear();
    categories = await categoryApi.get();
    setState(() {
      
    });
  }

  List<CourseModel> allCourses = [];
  List<CourseModel> courses = [];

  CourseController courseApi = CourseController();

  Future<void> getCourses() async {
    allCourses.clear();
    allCourses = await courseApi.get();
    courses = allCourses;
    setState(() {
      
    });
  }

  void findCourses(String keyword) {
    List<CourseModel> result = [];
    if (keyword.isEmpty) {
      result.clear();
      result = allCourses;
    } else {
      result.clear();
      result = result = allCourses.where((element) =>
          element.name.toLowerCase().contains(keyword.toLowerCase())
      ).toList();
    }
    setState(() {
      courses = result;
    });
  }

  @override
  void initState() {
    getCourses();
    getCategories();
    findCourses('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Course",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            searchWidget(),
            categoryWidget(),
            Expanded(
              child: iosWidget(),
            )
          ],
        ),
      )
    );
  }

  Widget iosWidget()
  {
    return new CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: getCourses,
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //     [
          //       searchWidget(),
          //       categoryWidget(),
          //       Padding(padding: EdgeInsets.only(bottom: 24))
          //     ]
          //   ),
          // ),
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
                SizedBox(height: 50)
              ]
            )
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
              textInputAction: TextInputAction.done,
              onChanged: (value) => findCourses(value),
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

  Widget categoryWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index){
                  return Container(
                    padding: EdgeInsets.only(right: 24),
                    child: ElevatedButton(
                      onPressed: () {},
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
                }),
              ),
            ),
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
                                      course.category!.name,
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
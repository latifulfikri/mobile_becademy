import 'dart:ui';

import 'package:becademy/apiController/categoryController.dart';
import 'package:becademy/main.dart';
import 'package:becademy/model/categoryModel.dart';
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

  Future<void> getCategories() async {
    categories.clear();
    categories = await categoryApi.get();
    setState(() {
      
    });
  }

  @override
  void initState() {
    getCategories();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: getCategories,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                mainWidget(),
                categoryWidget(),
                searchWidget(),
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
                    GoRouter.of(context).push("/course-detail");
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

  Widget recomendationWidget() {
    return new Row(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              courseItem("Dasar Pemrograman Menggunakan C", "CLI", 0.67),
              SizedBox(
                height: 16,
              ),
              courseItem("Dasar Database Menggunakan MySQL", "Database", 0.37),
              SizedBox(
                height: 16,
              ),
              courseItem("Membuat Landing Page", "Website", 0.13),
            ],
          ),
        )
      ],
    );
  }

  Widget courseItem(String title, String category, double progress) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24
      ),
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
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
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
                          category,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${(progress*100).toInt()}%")
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
                              widthFactor: progress,
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
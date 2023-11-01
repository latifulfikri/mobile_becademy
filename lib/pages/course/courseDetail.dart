import 'dart:ui';

import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseSlug;

  const CourseDetailPage({
    super.key,
    required this.courseSlug
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  
  var course = CourseModel(id: "loading", name: "loading", slug: "loading", desc: "loading", price: 0, min_processor: "loading", min_storage: 0, min_ram: 0, is_active: 0, created_at: "loading", updated_at: "loading", category: CategoryModel(id: "loading", name: "loading", slug: "loading", icon: "loading", color: "loading", created_at: "loading", updated_at: "loading"));

  List<CourseModel> courses = [];

  var price = "loading";

  CourseController courseApi = CourseController();
  
  Future<void> getCourse() async {
    Map<String,dynamic> res = await courseApi.getCourse(widget.courseSlug);
    if (res['status'] != 200) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: res['message'],
        confirmBtnColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        titleColor: Theme.of(context).colorScheme.secondary,
        textColor: Theme.of(context).colorScheme.secondary,
        onConfirmBtnTap: () {
          context.pop();
        }
      );
      setState(() {
        
      });
    } else {
      setState(() {
        course = CourseModel.fromJson(res['data']);
        price = NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0).format(course.price);
      });
    }
  }

  void displayDialog(BuildContext context, QuickAlertType type, String text) {
    QuickAlert.show(
      context: context,
      type: type,
      text: text,
      confirmBtnColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      titleColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.secondary,
      onConfirmBtnTap: () {

      }
    );
  }

  @override
  void initState() {
    getCourse();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        // leading: IconButton(
        //   onPressed: (){
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(FontAwesomeIcons.angleLeft)
        // ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Course",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: course != null ? courseFound() : courseNotFound()
    );
  }

  Widget courseFound() {
    return Stack(
        children: [
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  thumbnailWidget(),
                  courseName(),
                  courseCategory(),
                  courseDetail(),
                  courseDetail2(16, 72),
                  tutorWidget(),
                  moduleWidget(),
                  toolsWidget(),
                  SizedBox(
                    height: 120,
                  )
                ],
              )
            ],
          ),
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
                prizeBottomNavBar()
              ],
            ),
          )
        ],
      );
  }

  Widget courseNotFound() {
    return Stack(
        children: [
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  thumbnailWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24
                          ),
                          child: Text(
                            "Course not found",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  )
                ],
              )
            ],
          ),
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
                prizeBottomNavBar()
              ],
            ),
          )
        ],
      );
  }

  Widget thumbnailWidget()
  {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(24),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(24)
            ),
          )
        )
      ],
    );
  }

  Widget courseName()
  {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24
            ),
            child: Text(
              course.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget courseCategory()
  {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(24, 8, 24, 24),
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
          )
        ),
      ],
    );
  }

  Widget courseDetail()
  {
    return new Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24
            ),
            child: Text(course.desc),
          ),
        )
      ],
    );
  }

  Widget courseDetail2(int module, int time)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16
          ),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.solidBookmark,color: Theme.of(context).primaryColor),
              Padding(padding: EdgeInsets.only(right: 8)),
              Text("${module.toString()} modules"),
              Padding(padding: EdgeInsets.only(right: 24)),
              Icon(FontAwesomeIcons.solidClock,color: Theme.of(context).primaryColor,),
              Padding(padding: EdgeInsets.only(right: 8)),
              Text("${time.toString()} hours"),
            ],
          ),
        )
      ],
    );
  }

  Widget tutorWidget()
  {
    return new Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(24)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Tutor",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                tutorItemWidget("Tutor name", "Teaching Assistant")
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget tutorItemWidget(String name, String occupation)
  {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset("assets/brand/logo.png",width: 50,height: 50,fit: BoxFit.cover,),
        ),
        Padding(padding: EdgeInsets.only(right: 16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 4)),
              Text(
                occupation,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget moduleWidget()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24
                ),
                child: Text(
                  "Module",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 16)),
              materialWidget(
                "Pengenalan & Persiapan",
                [
                  materialItemWidget(2, "Apa itu algoritma"),
                  materialItemWidget(2, "Instalasi visual studio code"),
                ]
              ),
              Padding(padding: EdgeInsets.only(bottom: 16)),
              materialWidget(
                "Pemrograman",
                [
                  materialItemWidget(2, "Variabel, Array, Input & Output"),
                  materialItemWidget(1, "Operator dan operand"),
                  materialItemWidget(0, "Selection"),
                  materialItemWidget(0, "Repetition"),
                ]
              )
            ],
          ),
        )
      ],
    );
  }

  Widget materialWidget(String title, List<Widget> materialItems)
  {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(24)
            ),
            padding: EdgeInsets.all(24),
            margin: EdgeInsets.symmetric(
              horizontal: 24
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 6)),
                ...List.generate(
                  materialItems.length,
                  (index) => materialItems[index]
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget materialItemWidget(int status, String material)
  {
    // Color statusColor = Colors.transparent;
    // IconData statusIcon = FontAwesomeIcons.solidCircle;

    Color statusColor = Theme.of(context).primaryColor;
    IconData statusIcon = FontAwesomeIcons.book;

    // if (status == 2) {
    //   statusColor = Colors.green;
    //   statusIcon = FontAwesomeIcons.check;
    // } else if (status == 1) {
    //   statusColor = Colors.blue;
    //   statusIcon = FontAwesomeIcons.play;
    // }

    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: (){},
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        statusIcon,
                        size: 16,
                        color: Colors.white,
                        // color: status != 0 ? Colors.white : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 16)),
                Expanded(
                  child: Text(material),
                ),
                Icon(FontAwesomeIcons.angleRight)
              ],
            )
          ),
        ),
      ],
    );
  }

  Widget toolsWidget()
  {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tools",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                // processor
                Row(
                  children: [
                    Icon(FontAwesomeIcons.microchip),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Processor",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4)),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  course.min_processor,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    )
                  ],
                ),
                // end processor
                Padding(padding: EdgeInsets.only(bottom: 16)),
                // storage
                Row(
                  children: [
                    Icon(FontAwesomeIcons.solidHardDrive),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Storage",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4)),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${course.min_storage} GB",
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    )
                  ],
                ),
                // end storage
                Padding(padding: EdgeInsets.only(bottom: 16)),
                // ram
                Row(
                  children: [
                    Icon(FontAwesomeIcons.solidFloppyDisk),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "RAM",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4)),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${course.min_ram} GB",
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    )
                  ],
                )
                // end ram
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget prizeBottomNavBar()
  {
    return new Container(
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${price}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){},
                child: Text("Buy")
              )
            ],
          )
        ],
      )
    );
  }
}
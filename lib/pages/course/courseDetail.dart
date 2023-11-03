import 'dart:ui';

import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/apiController/moduleController.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:becademy/model/moduleModel.dart';
import 'package:flutter/cupertino.dart';
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
  
  CourseModel? course = CourseModel(id: "loading", name: "loading", slug: "loading", desc: "loading", price: 0, min_processor: "loading", min_storage: 0, min_ram: 0, is_active: 0, created_at: "loading", updated_at: "loading", category: CategoryModel(id: "loading", name: "loading", slug: "loading", icon: "loading", color: "loading", created_at: "loading", updated_at: "loading"));
  bool courseMember = false;

  Widget courseView() {
    if (course != null) {
      if (course!.name != "loading") {
        return courseFound();
      } else {
        return courseLoading();
      }
    } else {
      return courseNotFound();
    }
  }

  List<ModuleModel> modules = [];

  var price = "loading";

  CourseController courseApi = CourseController();
  ModuleController moduleApi = ModuleController();
  
  Future<void> getCourse() async {
    Map<String,dynamic> res = await courseApi.getCourse(widget.courseSlug);
    if (res['status'] != 200) {
      course = null;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: res['message'],
        confirmBtnColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        titleColor: Theme.of(context).colorScheme.secondary,
        textColor: Theme.of(context).colorScheme.secondary,
        onConfirmBtnTap: () {
          context.go("/");
        }
      );
      setState(() {
        
      });
    } else {
      isMember(res['data']['slug']);
      getModules(res['data']['slug']);
      course = CourseModel.fromJson(res['data']);
      if (course != null) {
        price = NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0).format(course!.price);
      }
      setState(() {
        
      });
    }
  }

  Future<void> getModules(String slug) async {
    List<ModuleModel>? result = await moduleApi.get(slug);
    modules.clear();
    if (result != null) {
      setState(() {
        modules = result;
      });
    }
  }

  Future<void> isMember(String slug) async {
    await courseApi.isMember(slug).then((value) {
      courseMember = value;
      setState(() {
        
      });
    });
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
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Kelas",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Stack(
        children: [
          courseView(),
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
      )
    );
  }

  Widget courseFound() {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: getCourse,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              thumbnailWidget(),
              courseName(),
              courseCategory(),
              courseDetail(),
              courseDetail2(72),
              tutorWidget(),
              moduleWidget(),
              toolsWidget(),
              SizedBox(
                height: 160,
              )
            ]
          )
        )
      ],
    );
  }

  Widget courseLoading() {
    return ListView(
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
                      "Loading",
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
    );
  }

  Widget courseNotFound() {
    return ListView(
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
                      "Kelas tidak ditemukan",
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
              course!.name,
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
            course!.category!.name,
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
            child: Text(course!.desc),
          ),
        )
      ],
    );
  }

  Widget courseDetail2(int time)
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
              Text("${modules.length} modul"),
              Padding(padding: EdgeInsets.only(right: 24)),
              Icon(FontAwesomeIcons.solidClock,color: Theme.of(context).primaryColor,),
              Padding(padding: EdgeInsets.only(right: 8)),
              Text("${time.toString()} jam"),
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
    if (modules.length > 0) {
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
                    "Modul",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                ...List.generate(modules.length, (index) {
                  if (modules[index].materials!.length > 0) {
                    return materialWidget(
                      modules[index].name,
                      [
                        ...List.generate(modules[index].materials!.length, (index2) {
                          return materialItemWidget(0, modules[index].materials![index2].name);
                        }),
                      ]
                    );
                  } else {
                    return materialWidget(
                      modules[index].name,
                      [
                        Row(
                          children: [
                            Expanded(
                              child: Text("Belum ada materi",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary
                                ),
                              ),
                            )
                          ],
                        )
                      ]
                    );
                  }
                }),
              ],
            ),
          )
        ],
      );
    } else {
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
                    "Modul",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                materialWidget(
                  "Belum ada modul",[]
                )
              ],
            ),
          )
        ],
      );
    }
  }

  Widget materialWidget(String title, List<Widget> materialItems)
  {
    if (materialItems.length < 0) {
      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(24)
              ),
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
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
                  Text("No material yet")
                ],
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(24)
              ),
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
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
  }

  Widget materialItemWidget(int status, String material)
  {
    // Color statusColor = Colors.transparent;
    // IconData statusIcon = FontAwesomeIcons.solidCircle;

    Color statusColor = Theme.of(context).primaryColor;
    IconData statusIcon = FontAwesomeIcons.book;

    if (status == 2) {
      statusColor = Colors.green;
      statusIcon = FontAwesomeIcons.check;
    } else if (status == 1) {
      statusColor = Colors.blue;
      statusIcon = FontAwesomeIcons.play;
    }

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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Spesifikasi minimum",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
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
                                  course!.min_processor,
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
                                  "${course!.min_storage} GB",
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
                                  "${course!.min_ram} GB",
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
    if (course != null) {
      if (course!.name != "loading") {
        if (courseMember == false) {
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
                      child: Text("Beli")
                    )
                  ],
                )
              ],
            )
          );
        } else {
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
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Text("Lanjut Belajar")
                      )
                    ),
                  ],
                )
              ],
            )
          );
        }
      } else {
        return SizedBox();
      }
    } else {
      return SizedBox();
    }
  }
}
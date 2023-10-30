import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
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
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Course",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  thumbnailWidget(),
                  courseName("Dasar pemrograman menggunakan bahasa C"),
                  courseCategory("CLI"),
                  courseDetail(
                    "Belajar tentang bangaimana melakukan dasar pemrograman menggunakan bahasa C. Mulai dari input dan output sederhana sampai dengan penerapan algoritma ke dalam program komputer",
                  ),
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
      ),
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

  Widget courseName(String title)
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
              title,
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

  Widget courseCategory(String category)
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
            category,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900
            ),
          )
        ),
      ],
    );
  }

  Widget courseDetail(String detail)
  {
    return new Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24
            ),
            child: Text(detail),
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
                Row(
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
                            "Tutor Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4)),
                          Text(
                            "Ocupation",
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
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
    Color statusColor = Colors.transparent;
    IconData statusIcon = FontAwesomeIcons.solidCircle;

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
                        color: status != 0 ? Colors.white : Colors.transparent,
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
                                  "Intel core i3 / Apple M1",
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                Row(
                  children: [
                    Icon(FontAwesomeIcons.windowMaximize),
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Operating System",
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
                                  "Windows / MacOS / Linux",
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    )
                  ],
                ),
                // end os
                Padding(padding: EdgeInsets.only(bottom: 16)),
                // start storage
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
                                  "10 GB",
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
                                  "4 GB",
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
                  "Rp 50,000",
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
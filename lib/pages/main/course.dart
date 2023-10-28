import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainCoursePage extends StatefulWidget {
  const MainCoursePage({super.key});

  @override
  State<MainCoursePage> createState() => _MainCoursePageState();
}

class _MainCoursePageState extends State<MainCoursePage> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        courseItem("Dasar Pemrograman Menggunakan C", "CLI", 0.67),
        SizedBox(
          height: 16,
        ),
        courseItem("Dasar Database Menggunakan MySQL", "Database", 0.37),
        SizedBox(
          height: 16,
        ),
        courseItem("Membuat Landing Page", "Website", 0.13),
        SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: (){},
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(FontAwesomeIcons.plus),
              SizedBox(width: 16,),
              Text("Daftar kelas baru")
            ],
          )
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
                  Text(title),
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
                            color: Colors.white,
                            fontWeight: FontWeight.w900
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
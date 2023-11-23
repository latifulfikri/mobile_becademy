import 'package:becademy/apiController/materialController.dart';
import 'package:becademy/model/materialModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

class MaterialsPage extends StatefulWidget {
  final String courseSlug;
  final String moduleSlug;
  final String materialSlug;

  const MaterialsPage({
    super.key,
    required this.courseSlug,
    required this.moduleSlug,
    required this.materialSlug,
  });

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  MaterialModel? material;
  MaterialController materialApi = MaterialController();

  Future<void> getMaterial() async {
    await materialApi.get(widget.courseSlug, widget.moduleSlug, widget.materialSlug).then((value){
      if (value['status'] == 200) {
        material = MaterialModel.fromJson(value['data']);
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: "${value['message']}",
          confirmBtnColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          titleColor: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.secondary,
          onConfirmBtnTap: (){
            context.pop();
            context.pop();
          },
        );
      }
      setState(() {
        
      });
    });
  }

  @override
  void initState() {
    getMaterial();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          material != null ? material!.name : "Material",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: new Stack(
        children: [
          MainBody(),
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
                BottomNav()
                // prizeBottomNavBar()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget MainBody()
  {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: getMaterial,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    material != null ? Html(
                      data: """${material!.body}""",
                      style: {
                        "img": Style(
                          padding: HtmlPaddings.symmetric(vertical: 12),
                        ),
                        "li": Style(
                          padding: HtmlPaddings.only(bottom: 12)
                        ),
                        "ol":Style(
                          padding: HtmlPaddings.only(bottom: 0),
                          margin: Margins.all(0)
                        ),
                      },
                    ):Text("nothing"),
                  ],
                ),
              ),
              SizedBox(
                height: 160,
              )
            ]
          )
        )
      ],
    );
  }

  Widget BottomNav() {
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
                  "Dashboard",
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
  }
}
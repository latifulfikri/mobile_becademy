import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/apiController/forumController.dart';
import 'package:becademy/apiController/materialController.dart';
import 'package:becademy/apiController/moduleController.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:becademy/model/forumModel.dart';
import 'package:becademy/model/materialModel.dart';
import 'package:becademy/model/moduleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String slug = "";
  MaterialModel? material;
  CourseModel? course;
  List<ModuleModel> modules = [];
  List<ForumModel> forums = [];
  
  MaterialController materialApi = MaterialController();
  CourseController courseApi = CourseController();
  ModuleController moduleApi = ModuleController();
  ForumController forumApi = ForumController();

  Future<void> getCourse() async {
    await courseApi.getCourse(widget.courseSlug).then((value){
      Map<String,dynamic> res = value;
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
        course = CourseModel.fromJson(res['data']);
        getModules(res['data']['slug']);
        setState(() {
          
        });
      }
    });
    
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

  Future<void> getForum(String slug) async {
    List<ForumModel>? result = await forumApi.get(slug);
    forums.clear();
    if (result != null) {
      forums = result;
      setState(() {

      });
    }
  }

  Future<void> getMaterial() async {
    await materialApi.get(widget.courseSlug, widget.moduleSlug, slug).then((value){
      if (value['status'] == 200) {
        material = MaterialModel.fromJson(value['data']);
        getForum(course!.slug);
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
    slug = widget.materialSlug;
    getMaterial();
    getCourse();
    getModules(widget.courseSlug);
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
        actions: <Widget>[
          Container()
        ],
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
      endDrawer: Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24)
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: DrawerContainer()
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(context).scaffoldBackgroundColor
                    ),
                    onPressed: (){
                      context.pop();
                    },
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.chevronLeft),
                        Text("Kembali"),
                        Expanded(child: Text(""))
                      ],
                    )
                  ),
                )
              ],
            )
          ),
        ),
      )
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
              forumSection(),
              SizedBox(
                height: 160,
              )
            ]
          )
        )
      ],
    );
  }

  Widget DrawerContainer() {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(24),
          child: Text(
            course != null ? course!.name : "Loading",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        moduleWidget()
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
              Builder(
                builder: (context) =>
                ElevatedButton(
                  onPressed: (){
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Icon(FontAwesomeIcons.solidBookmark),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor
                  )
                )
              ),
              SizedBox(width: 16,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: Text("Lanjut"),
                )
              ),
            ],
          )
        ],
      )
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
                Padding(padding: EdgeInsets.only(bottom: 16)),
                ...List.generate(modules.length, (index) {
                  if (modules[index].materials!.length > 0) {
                    return materialWidget(
                      modules[index].name,
                      [
                        ...List.generate(modules[index].materials!.length, (index2) {
                          return materialItemWidget(modules[index].materials![index2].id,modules[index].materials![index2].name,modules[index].slug,modules[index].materials![index2].slug);
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
                      ],
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

  Widget materialItemWidget(String materialid, String thematerial, String moduleSlug, String materialSlug)
  {
    // Color statusColor = Colors.transparent;
    // IconData statusIcon = FontAwesomeIcons.solidCircle;

    Color statusColor = Theme.of(context).colorScheme.tertiary;
    IconData statusIcon = FontAwesomeIcons.book;

    if (material != null) {
      if (material!.id == materialid) {
        statusColor = Theme.of(context).primaryColor;
      }
    }

    return TextButton(
      onPressed: (){
        slug = materialSlug;
        getMaterial();
        context.pop();
      },
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
            child: Text(thematerial),
          ),
          Icon(FontAwesomeIcons.angleRight)
        ],
      ),
    );
  }

  Widget forumSection()
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: 24),
          SectionTitle("Forum"),
          SizedBox(height: 16),
          ForumForm(),
          SizedBox(height: 16),
          ...List.generate(forums.length, (index) {
            return ForumItem(forums[index]);
          })
        ],
      ),
    );
  }

  Widget SectionTitle(String title)
  {
    return Row(
      children: [
        Text(title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }

  Widget ForumForm()
  {
    final TextEditingController _forumTextController = TextEditingController();
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: TextFormField(
                    minLines: 2,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    controller: _forumTextController,
                    decoration: InputDecoration(
                      hintText: "Tulis komentar",
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
          ),
          SizedBox(height: 16),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50)
              ),
              onPressed: () async {
                if (_forumTextController.text.trim().isEmpty ) {
                  print("empty bro");
                }
                // openApp = 0;
                // await loginAuth(_emailController.text, _passwordController.text);
              },
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Post")
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget ForumItem(ForumModel forum)
  {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(16)
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(21)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: Image.asset("assets/img/square-logo.png"),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(forum.account.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(forum.message)
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
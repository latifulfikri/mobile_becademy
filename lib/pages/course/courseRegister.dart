import 'dart:convert';
import 'dart:io';

import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/model/categoryModel.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class CourseRegisterPage extends StatefulWidget {
  final String courseSlug;

  const CourseRegisterPage({
    super.key,
    required this.courseSlug
  });

  @override
  State<CourseRegisterPage> createState() => _CourseRegisterPageState();
}

class _CourseRegisterPageState extends State<CourseRegisterPage> {

  CourseController courseApi = CourseController();
  CourseModel? course = CourseModel(id: "loading", name: "loading", slug: "loading", desc: "loading", price: 0, min_processor: "loading", min_storage: 0, min_ram: 0, is_active: 0, created_at: "loading", updated_at: "loading", category: CategoryModel(id: "loading", name: "loading", slug: "loading", icon: "loading", color: "loading", created_at: "loading", updated_at: "loading"));
  
  File? image;
  String? paymentMethod;

  bool courseMember = false;
  var price = "loading";

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
      course = CourseModel.fromJson(res['data']);
      if (course != null) {
        price = NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0).format(course!.price);
      }
      setState(() {
        
      });
    }
  }

  @override
  void initState() {
    getCourse();
    // TODO: implement initState
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          course==null? "Kelas" : course!.name,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Stack(
        children: [
          courseView()
        ],
      ),
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
              billDetail(),
              SizedBox(
                height: 24,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset("assets/img/square-logo.png"),
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

  Widget billDetail()
  {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      detailItem("ID Kelas", course!.id),
                      SizedBox(height: 12),
                      detailItem("Nama", course!.name),
                      SizedBox(height: 12),
                      detailItem("kategori", course!.category!.name),
                      SizedBox(height: 12),
                      detailItem("Modul", course!.modules!.length.toString()),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total tagihan"),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(price,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Theme.of(context).colorScheme.tertiaryContainer
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Text("Metode pembayaran"),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).scaffoldBackgroundColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.primary
                                  )
                                )
                              ),
                              hint: Text("Pilih metode pembayaran"),
                              items: [
                                DropdownMenuItem(value: "bank", child: Text("Bank")),
                                DropdownMenuItem(value: "ewallet", child: Text("E-Wallet")),
                                DropdownMenuItem(value: "direct", child: Text("Agent"))
                              ],
                              onChanged: (value){
                                paymentMethod = value;
                              },
                            )
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Text("Bukti pembayaran"),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                foregroundColor: Theme.of(context).colorScheme.tertiaryContainer
                              ),
                              onPressed: () async {
                                pickImageFromGalery();
                              },
                              child: Text("Tambahkan foto")
                            )
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      image != null ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(image!),
                      ) : Text("Belum ada foto yang dipilih", textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                            onPressed: () async {
                              if (image != null && paymentMethod != null) {
                                await courseApi.registerMember(course!.slug, image!, paymentMethod!).then((value){
                                    if (value != null) {
                                      Map<String, dynamic> res = jsonDecode(value.body);
                                      if (value.statusCode == 201) {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          text: res['data']['status'],
                                          confirmBtnColor: Theme.of(context).primaryColor,
                                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                                          titleColor: Theme.of(context).colorScheme.secondary,
                                          textColor: Theme.of(context).colorScheme.secondary,
                                          onConfirmBtnTap: () {
                                            context.pop();
                                            context.pop();
                                            context.push('/course/registered');
                                          },
                                        );
                                      } else {
                                        displayDialog(
                                          context,
                                          QuickAlertType.warning,
                                          res['data'].toString()
                                        );
                                      }
                                    } else {
                                      print("error");
                                    }
                                  }
                                );
                              } else {
                                displayDialog(
                                  context,
                                  QuickAlertType.error,
                                  "Metode pembayaran dan foto bukti pembayaran tidak boleh kosong"
                                );
                              }
                            },
                            child: Text("Continue Payment")),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
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
    );
  }

  Future pickImageFromGalery() async
  {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (returnedImage != null) {
        this.image = File(returnedImage!.path);
      }
    });
  }

  Widget detailItem(String att, String value)
  {
    return Row(
      children: [
        TextBold(att),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value,
                textAlign: TextAlign.end,
              )
            ],
          )
        )
      ],
    );
  }

  Widget TextBold(String text)
  {
    return Text(text,
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
    );
  }
}
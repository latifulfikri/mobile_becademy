import 'package:becademy/apiController/courseController.dart';
import 'package:becademy/apiController/memberController.dart';
import 'package:becademy/apiController/moduleController.dart';
import 'package:becademy/model/courseModel.dart';
import 'package:becademy/model/moduleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class ReceiptPage extends StatefulWidget {
  final String memberId;

  const ReceiptPage({
    super.key,
    required this.memberId,
  });

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  MemberController apiMember = MemberController();
  CourseController apiCourse = CourseController();
  ModuleController apiModule = ModuleController();

  Map<String, dynamic>? data;
  CourseModel? course;
  List<ModuleModel> modules = [];
  String price = "Loading";

  Future<void> getMemberData() async {
    await apiMember.get(widget.memberId).then((value){
      if(value['status'] == 200) {
        data = value['data'];
        getCourse(value['data']['course']['slug']);
        setState(() {
          
        });
      }
    });
  }

  Future getCourse(String courseSlug) async {
    Map<String,dynamic> res = await apiCourse.getCourse(courseSlug);
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
          context.pop();
          context.pop();
        }
      );
      setState(() {
        
      });
    } else {
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
    List<ModuleModel>? result = await apiModule.get(slug);
    modules.clear();
    if (result != null) {
      setState(() {
        modules = result;
      });
    }
  }

  @override
  void initState() {
    getMemberData();
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Invoice",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  thumbnailWidget(),
                  pageTitle(),
                  SizedBox(height: 24),
                  paymentInfo(),
                  SizedBox(height: 16),
                  course != null ? courseInfo() : Container()
                ],
              ),
            )
          ],
        ),
      )
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

  Widget pageTitle()
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
              "Invoice",
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

  Widget paymentInfo() {
    if (data != null) {
      return Row(
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBold("Payment ID"),
                            Text(data!['id'])
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBold("Payment at"),
                            Text(data!['created_at'])
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBold("Last updated at"),
                            Text(data!['updated_at'])
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 48),
                  detailItem("Payment bill", price),
                  SizedBox(height: 12),
                  detailItem("Payment method", data!['payment_method']),
                  SizedBox(height: 12),
                  detailItemWidget("Payment status", status()),
                  SizedBox(height: 24),
                  message()
                ],
              ),
            ),
          )
        ],
      );
    } else {
      return noPaymentInfo();
    }
  }

  Widget message() {
    String message = "Pembayaranmu ditolak";

    if (data!['payment_verified'] == "Success") {
      message = "";
    } else if (data!['payment_verified'] == "Process") {
      message = "Tunggu 1x24 jam sampai pembayaranmu terverifikasi";
    }

    if (data!['payment_verified'] != "Success") {
      return Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(message,
                    textAlign: TextAlign.center,
                  )
                ],
              )
            )
          )
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (){
                context.push('/course/'+course!.slug);
              },
              child: Text("Belajar sekarang")
            ),
          )
        ],
      );
    }
  }

  Widget detailItemWidget(String att, Widget value) {
    return Row(
      children: [
        TextBold(att),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              value
            ],
          )
        )
      ],
    );
  }

  Widget status() {
    Color bg = Colors.red;

    if (data!['payment_verified'] == "Success") {
      bg = Colors.green;
    } else if (data!['payment_verified'] == "Process") {
      bg = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Text(data!['payment_verified'].toString(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget category() {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Text(course!.category!.name,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    );
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

  Widget noPaymentInfo() {
    return Container(
      child: Center(
        child: Text("No payment information"),
      ),
    );
  }

  Widget courseInfo() {
    if (data != null) {
      return Row(
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBold("Course ID"),
                            Text(course!.id)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 48),
                  detailItem("Name", course!.name),
                  SizedBox(height: 10),
                  detailItemWidget("Category", category()),
                  SizedBox(height: 10),
                  detailItem("Min Processor", course!.min_processor),
                  SizedBox(height: 12),
                  detailItem("Min storage", course!.min_storage.toString()+" GB"),
                  SizedBox(height: 12),
                  detailItem("Min RAM", course!.min_ram.toString()+" GB"),
                ],
              ),
            ),
          )
        ],
      );
    } else {
      return noPaymentInfo();
    }
  }
}
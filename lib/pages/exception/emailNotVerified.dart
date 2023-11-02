import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ExceptionEmailNotVerified extends StatefulWidget {
  const ExceptionEmailNotVerified({super.key});

  @override
  State<ExceptionEmailNotVerified> createState() => _ExceptionEmailNotVerifiedState();
}

class _ExceptionEmailNotVerifiedState extends State<ExceptionEmailNotVerified> {
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

  @override
  void initState() {
    print("Udh masuk email not verified");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(FontAwesomeIcons.solidCircleXmark,
                    size: 64,
                    color: Colors.orange,
                  )
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text("Opps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text("Your email is not verified. Please click button bellow to resend your email verification",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 48)),
            ElevatedButton(
              onPressed: () async {
                var jwt = null;

                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                jwt = sharedPreferences.getString('jwt');

                if (jwt != null) {
                  try {
                    final response = await http.get(
                      Uri.parse(SERVER_API+"email/verify/resend"),
                      headers: {
                        'Authorization':'Bearer ${jwt}'
                      }
                    );
                    Map<String,dynamic> responseBody = jsonDecode(response.body);

                    if (response.statusCode == 201) {
                      sharedPreferences.remove('jwt').then((value){
                        setState(() {
                          userLoginData = null;
                        });
                        var uri = "/exception/email/sent:"+responseBody['data']['email'];
                        context.go(uri);
                      });
                    } else if (response.statusCode == 201) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        text: "Nothing to send. You email has been verified",
                        confirmBtnColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                        titleColor: Theme.of(context).colorScheme.secondary,
                        textColor: Theme.of(context).colorScheme.secondary,
                        onConfirmBtnTap: () {
                          sharedPreferences.remove('jwt').then((value){ 
                            setState(() {
                              userLoginData = null;
                            });
                          });
                          context.go("/login");
                        },
                      );
                    }
                  } catch (e) {
                    displayDialog(context, QuickAlertType.error, "Please check your internet connection");
                  }
                } else {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    text: "Cannot send your email verification, please login first",
                    confirmBtnColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                    titleColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.secondary,
                    onConfirmBtnTap: () {
                      sharedPreferences.remove('jwt').then((value){ 
                        setState(() {
                          userLoginData = null;
                        });
                      });
                      context.go("/login");
                    },
                  );
                }
              },
              child: Text("Send Email verification")
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove('jwt').then((value) => context.go('/login'));
              },
              child: Text("Go back to login"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Theme.of(context).primaryColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
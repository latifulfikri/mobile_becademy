import 'dart:convert';

import 'package:becademy/main.dart';
import 'package:becademy/model/accountModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible=false;

  Future getJwt() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');
    if (await jwt != null) {
      setUserLoginData(sharedPreferences);
    } else {
      setState(() {
        userLoginData = null;
      });
    }
  }

  @override
  void initState() {
    getJwt();
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void backToLogin()
  {
    context.push("/exception/emailNotVerified");
  }

  Future<void> setUserLoginData(SharedPreferences sharedPreferences) async {
    var jwt = sharedPreferences.getString('jwt');

    await http.get(
      Uri.parse(SERVER_API+"my/data"),
      headers: {
        'Authorization':'Bearer ${jwt}'
      }
    ).then((value) {

      Map<String,dynamic> responseBody = jsonDecode(value.body);

      if(value.statusCode == 403) {
        print("not verified");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: "Your email is not verified. Click the button bellow to send email verification",
          confirmBtnColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          titleColor: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.secondary,
          onConfirmBtnTap: () async {
            await http.get(
              Uri.parse(SERVER_API+"email/verify/resend"),
              headers: {
                'Authorization':'Bearer ${jwt}'
              }
            ).then((value){
              print("send");
              Navigator.pop(context);
              displayDialog(context, QuickAlertType.success, "Verification link has been sent to your email");
            });
          },
          confirmBtnText: "Send email verification"
        );
      } else if (value.statusCode == 200) {
        setState(() {
          userLoginData = AccountModel.fromJson(responseBody['data']);
        });
        context.go("/");
      } else {
        setState(() {
          sharedPreferences.remove('jwt');
          userLoginData = null;
        });
      }
    });
  }

  Future<void> loginAuth(String email, String password) async {
    var res = await http.post(
      Uri.parse(SERVER_API+"login"),
      body: {
        "email": email,
        "password": password,
      }
    );
      Map<String,dynamic> body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        // secstorage.write(key: 'jwt', value: body['access_token']);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('jwt', body['access_token']);
        setUserLoginData(sharedPreferences);
      } else {
        List<String> errors = [];
        if (body['data'].length > 0) {
          body['data'].forEach((key, value) {
            errors.add(value[0].toString());
          });
          displayDialog(
            context,
            QuickAlertType.error,
            errors[0]
          );
        } else {
          displayDialog(
            context,
            QuickAlertType.error,
            body['message']
          );
        }
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                pageTitle(),
                Padding(padding: EdgeInsets.only(bottom: 48)),
                loginForm(),
                Padding(padding: EdgeInsets.only(bottom: 48)),
                brandImage(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget pageTitle()
  {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 42
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text("Gunakan akun yang sudah terdaftar"),
            )
          ],
        ),
      ],
    );
  }

  Widget loginForm()
  {
    return Column(
      children: [
        Row(
          children: [
            Text("Email")
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "your-email@email.com",
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
        Padding(padding: EdgeInsets.only(bottom: 24)),
        Row(
          children: [
            Text("Password")
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  controller: _passwordController,
                  obscureText: passwordVisible == true ? false : true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "password",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.all(4),
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: passwordVisible == true ? Icon(FontAwesomeIcons.eyeSlash) : Icon(FontAwesomeIcons.eye),
                        iconSize: 20,
                      ),
                    ),
                  ),
                )
              ),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 24)),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50)
            ),
            onPressed: () async {
              await loginAuth(_emailController.text, _passwordController.text);
            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("Login")
              ],
            )
          ),
        ),
      ],
    );
  }

  Widget brandImage()
  {
    return new Row(
      children: [
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Image.asset(
              MediaQuery.of(context).platformBrightness == Brightness.light ? "assets/brand/logo-text.png" : "assets/brand/logo-text-white.png",
              height: 48,
              fit: BoxFit.contain,
            ),
          ),
        )
      ],
   );
  }
}
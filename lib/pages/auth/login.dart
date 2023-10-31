import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible=false;
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
    return new Column(
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
    return new Column(
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
            onPressed: (){
              context.go("/");
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
import 'package:becademy/apiController/accountController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  var passwordVisible = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmationController = TextEditingController();

  AccountController accountApi = AccountController();

  Future<void> changeMyPassword(String password, String newPassword, String newPasswordConfirmation) async {
    accountApi.changePassword(password, newPassword, newPasswordConfirmation).then((value){
      if (value['status'] == 200) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: value['message'],
          confirmBtnColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          titleColor: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.secondary,
          onConfirmBtnTap: () {
            context.pop();
            context.pop();
          }
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: value['message'],
          confirmBtnColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          titleColor: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.secondary,
          onConfirmBtnTap: () {
            context.pop();
          }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Password",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: Column(
                            children: [
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
                                        color: Theme.of(context).scaffoldBackgroundColor,
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
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("New password")
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(16)
                                      ),
                                      child: TextField(
                                        textInputAction: TextInputAction.go,
                                        controller: _newPasswordController,
                                        obscureText: passwordVisible == true ? false : true,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          hintText: "new password",
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
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Text("Confirm new password")
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(16)
                                      ),
                                      child: TextField(
                                        textInputAction: TextInputAction.go,
                                        controller: _newPasswordConfirmationController,
                                        obscureText: passwordVisible == true ? false : true,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          hintText: "new password",
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
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            changeMyPassword(_passwordController.text.toString(), _newPasswordController.text.toString(), _newPasswordConfirmationController.text.toString());
                          },
                          child: Text("Ganti password")
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ),
      )
    );
  }
}
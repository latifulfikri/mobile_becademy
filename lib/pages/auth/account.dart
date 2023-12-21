import 'dart:convert';

import 'package:becademy/apiController/accountController.dart';
import 'package:becademy/main.dart';
import 'package:becademy/model/accountModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  var verified = false;
  var edit = false;

  String gender = userLoginData!.gender;
  String degree = userLoginData!.degree;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  AccountController accountApi = AccountController();

  Future getProfileData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwt = sharedPreferences.getString('jwt');

    await http.get(
      Uri.parse(SERVER_API+"my/data"),
      headers: {
        'Authorization':'Bearer ${jwt}'
      }
    ).then((value) {
      Map<String,dynamic> responseBody = jsonDecode(value.body);
      if (value.statusCode == 200) {
        AccountModel account = AccountModel.fromJson(responseBody['data']);
        userLoginData = account;
        setFormValue();
        setState(() {
          
        });
      } else {
        setState(() {
          sharedPreferences.remove('jwt');
          userLoginData = null;
        });
        context.go("/login");
      }
    });
  }

  void setFormValue() {
    _userNameController.text = userLoginData?.name ?? "";
    gender = userLoginData!.gender;
    degree = userLoginData!.degree;
    _schoolController.text = userLoginData?.school ?? "";
    _fieldOfStudyController.text = userLoginData?.field_of_study ?? "";
    _titleController.text = userLoginData?.title ?? "";
    _companyController.text = userLoginData?.company ?? "";
    _locationController.text = userLoginData?.location ?? "";
  }

  @override
  void initState() {
    if (userLoginData != null) {
      if (userLoginData!.email_verified_at != null) {
        setFormValue();
        setState(() {
          verified = true;
        });
      }
    }
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
          "Akun",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                getProfileData();
              },
            ),
            edit == true ? editScreen() : mainScreen()
          ],
        ),
      ),
    );
  }

  Widget mainScreen() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          mainProfile(),
          profileDetail(),
          backgroundDetail(),
          profileEditButton(),
          SizedBox(height: 48)
        ]
      )
    );
  }

  Widget editScreen() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          profileDetailEdit(),
          backgroundDetailEdit(),
          profileSaveButton(),
          SizedBox(height: 48)
        ]
      )
    );
  }

  Widget mainProfile() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(24)
                      ),
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          // name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  userLoginData != null ? userLoginData!.name : "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // field of study
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  userLoginData != null ? userLoginData!.field_of_study : "",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          // email
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 16
                                  ),
                                  height: 1,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  userLoginData != null ? userLoginData!.email : "",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: verified ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(16)
                                ),
                                margin: EdgeInsets.only(top: 16),
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      verified ? "Verified" : "Not verified",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 8)),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          // profile picture
          Column(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(70)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(SERVER_WEB+"account/img/"+userLoginData!.picture),
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  Widget profileDetail() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailItem("Nama", userLoginData!.name),
                  SizedBox(height: 8),
                  detailItem("Email", userLoginData!.email),
                  SizedBox(height: 8),
                  detailItem("Jenis Kelamin", userLoginData!.gender),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget profileDetailEdit() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama"),
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
                            textInputAction: TextInputAction.next,
                            controller: _userNameController,
                            decoration: InputDecoration(
                              hintText: "your name",
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
                  Text("Email"),
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
                              Text(userLoginData!.email,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
                  Text("Jenis kelamin"),
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
                          hint: Text(userLoginData!.gender),
                          items: [
                            DropdownMenuItem(value: "Male", child: Text("Male")),
                            DropdownMenuItem(value: "Female", child: Text("Female")),
                          ],
                          onChanged: (value){
                            
                          },
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget backgroundDetail() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Row(
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
                  detailItem("Tingkat", userLoginData!.degree),
                  SizedBox(height: 8),
                  detailItem("Sekolah", userLoginData!.school),
                  SizedBox(height: 8),
                  detailItem("Jurusan", userLoginData?.field_of_study ?? ""),
                  SizedBox(height: 8),
                  detailItem("Posisi", userLoginData?.title ?? "-"),
                  SizedBox(height: 8),
                  detailItem("Perusahaan", userLoginData?.company ?? "-"),
                  SizedBox(height: 8),
                  detailItem("Lokasi", userLoginData?.location?? "-"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget backgroundDetailEdit() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tingkat pendidikan"),
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
                          hint: Text(degree),
                          items: [
                            DropdownMenuItem(value: "High School", child: Text("SMP/SMA")),
                            DropdownMenuItem(value: "S1", child: Text("S1")),
                            DropdownMenuItem(value: "S2", child: Text("S2")),
                            DropdownMenuItem(value: "S3", child: Text("S3")),
                          ],
                          onChanged: (value){
                            
                          },
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Sekolah"),
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
                            textInputAction: TextInputAction.next,
                            controller: _schoolController,
                            decoration: InputDecoration(
                              hintText: "Nama sekolah / universitas",
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
                  Text("Jurusan"),
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
                            textInputAction: TextInputAction.next,
                            controller: _fieldOfStudyController,
                            decoration: InputDecoration(
                              hintText: "Jurusan pendidikan",
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
                  Text("Posisi pekerjaan"),
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
                            textInputAction: TextInputAction.next,
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: "-",
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
                  Text("Nama perusahaan"),
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
                            textInputAction: TextInputAction.next,
                            controller: _companyController,
                            decoration: InputDecoration(
                              hintText: "-",
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
                  Text("Lokasi perusahaan"),
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
                            textInputAction: TextInputAction.next,
                            controller: _locationController,
                            decoration: InputDecoration(
                              hintText: "-",
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget profileEditButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (){
                edit = true;
                setState(() {
                  
                });
              },
              child: Text("Edit profil")
            )
          )
        ],
      ),
    );
  }

  Widget profileSaveButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (){
                accountApi.updateProfile(_userNameController.text.toString(), gender, degree, _schoolController.text.toString(), _fieldOfStudyController.text.toString(), _titleController.text.toString(), _companyController.text.toString(), _locationController.text.toString()).then((value){
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
                        getProfileData();
                        edit = false;
                        setState(() {
                          
                        });
                        context.pop();
                      },
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
                      },
                    );
                  }
                });
                setState(() {
                  
                });
              },
              child: Text("Simpan")
            )
          )
        ],
      ),
    );
  }

  Widget detailItem(String att, String value)
  {
    return Column(
      children: [
        Row(
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
        ),
        
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
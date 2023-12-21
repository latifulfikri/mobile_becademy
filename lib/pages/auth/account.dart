import 'package:becademy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  var verified = false;

  @override
  void initState() {
    if (userLoginData != null) {
      if (userLoginData!.email_verified_at != null) {
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

              },
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  mainProfile(),
                  profileDetail(),
                  backgroundDetail()
                ]
              )
            )
          ],
        ),
      ),
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
                  detailItem("Tempat", userLoginData?.location?? "-"),
                ],
              ),
            ),
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
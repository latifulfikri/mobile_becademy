import 'package:becademy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {

  Future<void> get() async {

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: CustomScrollView(
        slivers: [
          // const SliverAppBar(
          //   pinned: false,
          //   floating: true,
          //   title: Padding(padding: EdgeInsets.all(16), child: Text("Kelasku", style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 24
          //   ),),),
          //   centerTitle: false,
          //   elevation: 0,
          // ),
          CupertinoSliverRefreshControl(
            onRefresh: get,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                mainProfile(),
                discordButton(),
                profileSettings(),
                Padding(padding: EdgeInsets.only(bottom: 16)),
                accountAction(),
                const SizedBox(
                  height: 160,
                )
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget mainProfile() {
    return new Container(
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
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(24)
                      ),
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Nick Nelson",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "School of Computer Science",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 16
                                  ),
                                  height: 1,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "nick.nelson@gmail.com",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                      "Verified",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.green
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(right: 8)),
                                    Icon(
                                      FontAwesomeIcons.check,
                                      color: Colors.green,
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

  Widget discordButton() {
    return new Container(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50)
        ),
        onPressed: (){},
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(FontAwesomeIcons.discord),
            Padding(padding: EdgeInsets.only(right: 16)),
            Text("Buka server discord")
          ],
        )
      ),
    );
  }

  Widget profileSettings() {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          profileSettingButton(FontAwesomeIcons.solidUser, "Akun"),
          profileSettingButton(FontAwesomeIcons.lock, "Password"),
          profileSettingButton(FontAwesomeIcons.cartShopping, "Pesanan"),
          profileSettingButton(FontAwesomeIcons.shield, "Keamanan"),
          profileSettingButton(FontAwesomeIcons.solidClipboard, "Aturan & Layanan"),
        ],
      ),
    );
  }

  Widget accountAction() {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.remove('jwt');
              setState(() {
                userLogin.setData(false);
              });
              context.go('login');
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.doorOpen,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 16)),
                Expanded(
                  child: Text("Keluar"),
                ),
                Icon(FontAwesomeIcons.angleRight)
              ],
            )
          )
        ],
      ),
    );
  }

  Widget profileSettingButton(IconData icon, String text) {
    return new TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: (){},
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 16)),
          Expanded(
            child: Text(text),
          ),
          Icon(FontAwesomeIcons.angleRight)
        ],
      )
    );
  }
}
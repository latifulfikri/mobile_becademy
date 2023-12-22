import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Keamanan",
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
                // getProfileData();
              },
            ),
            mainScreen()
          ],
        ),
      ),
    );
  }

  Widget mainScreen() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          mainWidget()
          // mainProfile(),
          // profileDetail(),
          // backgroundDetail(),
          // profileEditButton(),
          // SizedBox(height: 48)
        ]
      )
    );
  }

  Widget mainWidget()
  {
    return Container(
      padding: EdgeInsets.all(24),
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
                  tncItem("Kemanan Aplikasi",
                  "Becademy mengambil Langkah keamanan yang sesuai untuk melindungi data dan privasi pengguna dari akses tidak sah, perubahan, pengungkapan, atau penghancuran data pribadi. Namun sayangnya, tidak ada sistem keamanan yang bisa menjamin 100% keamanan data dari akses tidak sah oleh pihak ketiga. Anda sebagai pengguna aplikasi juga berkewajiban untuk melindungi kata sandi anda. Jangan membagikan kata sandi dan data kredensial lainnya kepada orang lain, karena anda juga merupakan bagian penting dari sistem keamanan kami dan ikut bertanggung jawab terhadap keamanan akun anda sendiri."),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tncItem(String title, String body)
  {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(body,
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
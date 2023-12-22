import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({super.key});

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Aturan & Layanan",
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
                  tncItem("Penerimaan Persyaratan",
                  "Dengan menggunakan aplikasi Becademy, maka anda menyatakan diri setuju dengan syarat dan ketentuan aplikasi ini. Syarat dan ketentuan lengkap aplikasi Becademy akan dijelaskan lebih detail pada poin-poin berikut"),
                  SizedBox(height: 16),
                  tncItem("Akun",
                  "Anda memerlukan akun jika ingin mengakses di platfom kami, termasuk untuk melakukan proses transaksi dan mengakses konten atau mempublikasi konten. Ketika mengatur akun, anda diharapkan memberikan informasi yang lengkap dan akurat, serta juga memberikan alamat email yang valid. Anda akan bertanggung jawab sepenuhnya terhadap akun anda dan semua yang terjadi di akun anda, termasuk pelanggaran-pelanggaran yang terjadi apabila ada orang lain yang berusaha mengakses akun anda tanpa seizin anda. Anda harus berhati-hati terhadap informasi penting dan password akun anda. Anda tidak diperkenankan untuk memindahkan informasi pribadi akun anda ke akun lain begitupun sebaliknya.\n\nAnda tidak diperkenankan untuk menyebarluaskan login credential anda ke semua orang. Anda harus bertanggung jawab terhadap akun anda dan Becademy tidak akan ikut campur tangan dalam urusan pelajar dan instructor yang bertukar akun.\n\nStudent dan instructor harus minimal berumur 18 tahun jika ingin membuat akun Becademy dan menggunakan layanannya. Jika user berumur dibawah dari 18 tahun maka diharapkan agar orang tua atau pendamping user untuk membantu membuat akun dan mengakses layanan becademy untuk mereka. Jika kami menemukan anda membuat akun dan melakukan pelanggaran terhadap aturan yang telah kita buat, maka kami akan menghapus akun anda."),
                  SizedBox(height: 16),
                  tncItem("Layanan",
                  "Becademy memberikan layanan sebagai platform e-learning yang memfasilitasi pembelajaran keterampilan pemrograman dan coding kepada pengguna yang telah mendaftarkan akun dan membeli kelas maupun berlangganan pada platform kami. Materi yang disediakan di dalam aplikasi Becademy dapat berupa video pembelajaran, modul tertulis, akses komunitas dan forum, dan akses terhadap kelas atau pertemuan live secara online."),
                  SizedBox(height: 16),
                  tncItem("Pembayaran dan Langganan",
                  "Harga\nHarga dari setiap konten dan kelas yang ada di dalam aplikasi Becademy ditentukan berdasarkan ketentuan dan kesepakatan antara pihak aplikasi dan instructor. Harga setiap kelas juga dapat bervariasi, bergantung pada materi dan tingkat kesulitan kelas.\n\nPembayaran\nPengguna setuju untuk membayar biaya berlangganan yang berlaku untuk mengakses konten premium dan layanan eksklusif di dalam aplikasi. Pembayaran dapat dilakukan melalui metode yang disediakan di aplikasi dan akan diperlakukan sebagai persetujuan untuk berlangganan."),
                  SizedBox(height: 16),
                  tncItem("Konten dan Kah Cipta",
                  "Semua materi pembelajaran yang disediakan di dalam aplikasi Becademy dilindungi oleh hak cipta dan merupakan milik Perusahaan atau platform Becademy atau pihak ketiga yang telah memberikan izin penggunaan kepada Becademy."),
                  SizedBox(height: 16),
                  tncItem("Perubahan syarat dan ketentuan", "Becademy berhak untuk mengubah syarat dan ketentuan ini. Perubahan tersebut akan diberitahukan kepada pengguna melalui pemberitahuan di dalam aplikasi atau melalui kontak email yang terdaftar."),
                  SizedBox(height: 16),
                  tncItem("Penolakan Tanggung Jawab", 
                  "Becademy tidak bertanggung jawab atas kehilangan atau kerugian yang disebabkan oleh penggunaan atau ketidakmampuan menggunakan aplikasi Becademy."),
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
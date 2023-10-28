import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainNotificationPage extends StatefulWidget {
  const MainNotificationPage({super.key});

  @override
  State<MainNotificationPage> createState() => _MainNotificationPageState();
}

class _MainNotificationPageState extends State<MainNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        notificationItem(true, "Rekomendasi", DateTime.now(),"Selesaikan course Dasar Pemrograman Menggunakan Bahasa C course 3 sebelum tanggal 31 Agustus 2023"),
        notificationItem(false, "Pembayaran", DateTime.now(),"Pembayaran course Membuat Landing Page berhasil"),
        notificationItem(false, "Pembayaran", DateTime.now(),"Pembayaran course Dasar Database Menggunakan MySQL berhasil"),
      ],
    );
  }

  Widget notificationItem(bool isNew, String title, DateTime date, String body) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.fromLTRB(24, 0, 24, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(24)
      ),
      child: Column(
        children: [
          Row(
            children: [
              dotNotification(isNew),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: isNew == true ? FontWeight.bold : FontWeight.normal,
                    color: isNew == true ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiary
                  ),
                ),
              ),
              Text(
                DateFormat.MMMd('en_US').format(date),
                style: TextStyle(
                  fontWeight: isNew == true ? FontWeight.bold : FontWeight.normal,
                  color: isNew == true ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiary
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10
                  ),
                  height: 2,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  body,
                  style: TextStyle(
                    color: isNew == true ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.tertiary
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget dotNotification(bool isNew) {
    if(isNew == true) {
      return new Container(
        width: 10,
        height: 10,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).primaryColor
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationSent extends StatefulWidget {
  const EmailVerificationSent({
    super.key,
    required this.message
  });

  final String message;

  @override
  State<EmailVerificationSent> createState() => _EmailVerificationSentState();
}

class _EmailVerificationSentState extends State<EmailVerificationSent> {
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
                  child: Icon(FontAwesomeIcons.solidCircleCheck,
                    size: 64,
                    color: Colors.green,
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
                  child: Text("Great!",
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
                  child: Text("Verification link has been sent to ${widget.message}",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 48)),
            ElevatedButton(
              onPressed: () async {
                context.go('/login');
              },
              child: Text("Go back to login")
            ),
          ],
        ),
      ),
    );
  }
}
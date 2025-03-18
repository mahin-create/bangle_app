import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactpage extends StatefulWidget {
  const Contactpage({super.key});

  @override
  State<Contactpage> createState() => _ContactpageState();
}

class _ContactpageState extends State<Contactpage> {
  final TextEditingController control = TextEditingController();

  void sms() async {
    String phonenumber = control.text;
    String message = Uri.encodeComponent('This is an alert message');
    String smsUrl = "sms:$phonenumber?body=$message";

    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
    } else {
      print('Could not send SMS');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Number'), backgroundColor: Colors.blue),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: control,
              decoration: InputDecoration(
                hintText: 'Enter the number',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: sms, child: Text('Send SMS')),
          ],
        ),
      ),
    );
  }
}

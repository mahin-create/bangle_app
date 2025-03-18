import 'package:bangle_app/contactpage.dart';
import 'package:bangle_app/firstpage.dart';
import 'package:bangle_app/mappage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Contactpage());
  }
}

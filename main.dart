import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_to_app/Models/DatabaseNote.dart';
import 'package:to_to_app/Screens/CalenderScreen.dart';
import 'package:to_to_app/Screens/GetStarted.dart';
import 'Screens/HomePage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseNote.initDb();
  await DatabaseNote.getNotes();
  await DatabaseNote.getNotesOfDay(DateFormat.yMd().format(DateTime.now()), 0);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: GetStarted(),
    );
  }
}
















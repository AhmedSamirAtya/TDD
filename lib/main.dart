import 'package:flutter/material.dart';
import 'package:tdd/business/cubit/cubit/notes_cubit.dart';
import 'package:tdd/presentaion/screens/myhomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        notesCubit: NotesCubit(),
      ),
    );
  }
}
// lib/home_page.dart

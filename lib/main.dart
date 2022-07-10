import 'package:flutter/material.dart';
import 'ui/screens/home.dart';

void main()  {
  // This widget is the root of your application.

  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
      title: 'Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
          backgroundColor: Colors.white
      ),
      home: const Home(),
    ));
  }


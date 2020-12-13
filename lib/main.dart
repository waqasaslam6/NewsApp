import 'package:flutter/material.dart';
import 'package:news_app_api/views/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaqasNews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple[300],
        appBarTheme: AppBarTheme(
          color: Colors.purple,
          iconTheme: IconThemeData(
            color: Colors.purple
          )
        )
      ),
      home: HomePage(),

    );
  }
}

import 'package:flutter/material.dart';
import 'screens/detail_screen.dart';
import 'screens/list_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/photo_screen.dart';

class App extends StatelessWidget {

  static final routes = {
    DetailScreen.routeName: (context) => DetailScreen(),
    ListScreen.routeName: (context) => ListScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
    PhotoScreen.routeName: (context) => PhotoScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      initialRoute: ListScreen.routeName,
      routes: routes
    );
  }
}
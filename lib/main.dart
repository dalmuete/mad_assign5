import 'package:flutter/material.dart';
import 'package:assign_5/providers/song_provider.dart';
import 'package:provider/provider.dart';
import 'package:assign_5/screens/song_list_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SongProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Favorites',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SongListScreen(),
    );
  }
}

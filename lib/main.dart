import 'package:flutter/material.dart';
import 'package:media/features/home/home_page.dart';
import 'package:media/utils/song_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SongDatabase songDatabase;
late SharedPreferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  songDatabase = SongDatabase.instance;
  await songDatabase.database;
  preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

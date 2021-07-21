import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/screen/home_screen.dart';
import 'package:flutter_test_app/widget/bottom_bar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
// Stateful -> Homepage를 사용하지 않는 방식
class MyApp extends StatefulWidget{
  // My App에 대한 상태를 관리
  _MyAppState createState() => _MyAppState();
}
// MyApp을 Class로 만듬
class _MyAppState extends State<MyApp>{
  late TabController controller;
  @override
  Widget build(BuildContext context){
    // 기본적인 MaterialApp Setting
    return MaterialApp(title: 'NetFlix',
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: Colors.white
    ),
      home:DefaultTabController(
        // 하단 메뉴바 개수
        length: 4,
        child: Scaffold(
          body: TabBarView(
              // 사용자가 직접 스크롤 하는 기능을 막겟다
              physics: NeverScrollableScrollPhysics(),
              children:<Widget>[
                HomeScreen(),
                Container(child: Center(child: Text('search'),),),
                Container(child: Center(child: Text('save'),),),
                Container(child: Center(child: Text('more'),),)
              ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/model/model_movie.dart';
import 'package:flutter_test_app/widget/box_slider.dart';
import 'package:flutter_test_app/widget/carousel_slider.dart';
import 'package:flutter_test_app/widget/circle_slider.dart';

// backend에 데이터를 들고와야하기 때문에 statefulwidget
class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;
  @override
  void initState() {
    super.initState();
    streamData = firestore.collection('movie').snapshots();
  }
  // Firebase에서 Widget으로 옮김
  Widget _fetchData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data!.docs);
      },
    );
  }
  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapShot){
    List<Movie> movies = snapShot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[CarouselImage(movies: movies), TopBar()],
        ),
        CircleSlider(
          movies: movies,
        ),
        BoxSlider(
          movies: movies,
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context){
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // pubspec.yaml에 이미지를 추가하면 Image.asset 가능
          Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 컨텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/model/model_movie.dart';
import 'package:flutter_test_app/screen/detail_screen.dart';

// StatefulWidget을 한 이유는 이미지뿐만 아니라 영화 정보 등을 띄어주는 역할을 해서
class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({required this.movies});
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keyword;
  late List<bool> likes;
  // 최근 페이지
  int _currentPage = 0;
  late String _currentKeyword;
  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m) => Image.network(m.poster)).toList();
    keyword = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keyword[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: images,
            options: CarouselOptions(onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keyword[_currentPage];
              });
            }),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          // Like Button
          Container(
            child: Row(
              // 가운데 정렬
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      // Like를 눌렀을 경우와 안눌렷을 경우 Icon의 형태를 바꾸기 위해
                      likes[_currentPage]
                          ? IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference.update({
                                    'like': likes[_currentPage]
                                  });
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage].reference.update({
                                    'like': likes[_currentPage]
                                  });
                                });
                              },
                            ),
                      Text(
                        '내가 찜한 컨텐츠',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
                // Play 버튼
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.play_arrow, color: Colors.black),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                // 목록 버튼
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                                fullscreenDialog: true,
                                builder: (BuildContext context) {
                                  return DetailScreen(
                                    movie: movies[_currentPage],
                                  );
                                }));
                          },
                          icon: Icon(Icons.info)),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 재생 밑에 동그라미
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: makeIndicator(likes, _currentPage)),
          )
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          // 해당 페이지가 맞으면 색깔 진하게 아니면 연하게
          color: _currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }
  return result;
}

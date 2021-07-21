import 'package:cloud_firestore/cloud_firestore.dart';


class Movie{
  // 모델에 들어갈 영화의 기본 구성들
  final String title;
  final String keyword;
  final String poster;
  // 찜 여부
  final bool like; 
  final DocumentReference reference;
  
  // Named 생성자 기능
  // Named Constructor: You can use any name on [fromMap]
  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
  :title = map['title'],
   keyword = map['keyword'],
   poster = map['poster'],
   like = map['like'];

   
  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$keyword>";
}
class Movie{
  // 모델에 들어갈 영화의 기본 구성들
  final String title;
  final String keyword;
  final String poster;
  // 찜 여부
  final bool like; 
  
  // Named 생성자 기능
  // Named Constructor: You can use any name on [fromMap]
  Movie.fromMap(Map<String, dynamic> map)
  :title = map['title'],
   keyword = map['keyword'],
   poster = map['poster'],
   like = map['like'];

   @override
   String toString() => "Movie<$title:$keyword>";
}
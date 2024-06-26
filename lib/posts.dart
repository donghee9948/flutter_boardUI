import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import '/navigation/navigationScreen.dart';
import '/write.dart';
import 'package:splash_screen/detail.dart';

class PostDto {
  final int id;
  final String title;
  final String content;
  final String memberName;
  final int goodCount;
  final int commentCount;



  PostDto({required this.id,required this.title, required this.content,required this.memberName, required this.goodCount,required this.commentCount});

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      memberName: json['memberName'],
      goodCount: json['goodCount'],
      commentCount: json['commentCount'],


    );
  }
}

class PostListScreen extends StatefulWidget {
  final String boardName;
  final int boardId;

  PostListScreen(this.boardName,this.boardId);
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {

  late ScrollController _scrollController;
  late List<PostDto> posts = [];
  bool isFavorite = false;
  int page = 0;
  int pageSize = 10;
  bool isLoading = false;
  Color iconColor = Colors.grey;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      iconColor = isFavorite ? Colors.red : Colors.grey;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchPosts();
  }
  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  Future<void> fetchPosts() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('http://59.11.250.234:8080/posts?page=$page&pageSize=$pageSize&boardId=${widget.boardId}'));
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        posts.addAll(jsonData.map((data) => PostDto.fromJson(data)).toList());
        page++;
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (posts == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFE9ECEF),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        shape: Border(
          bottom: BorderSide(
            color: Color(0xffe9ecef),
            width: 1.3,
          ),
        ),

        title: Text(widget.boardName),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(icon: SvgPicture.asset('asset/icons/search.svg',width: 35,height: 35,),onPressed: () => print("버튼 클릭 시 검색") ,),
          ),
        ],
      ),
      body: ListView.builder(

        itemCount: posts.length + (isLoading ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if(index < posts.length) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 1), // 그림자의 위치 조정
                    ),
                  ],
                ),
                child: ListTile(
                  title: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        SizedBox(width: 8), // CircleAvatar와 작성자 이름 사이의 간격 조절
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  posts[index].memberName, // 작성자 이름 표시
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '수원대학교', // 작성자 학교 표시
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8), // 각 항목 사이의 간격 추가
                          ],
                        ),
                        Spacer(), // 작성자 이름과 날짜 사이에 공간을 확장합니다.
                        Text(
                          '5분전', // 날짜 표시 예시
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts[index].title,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        posts[index].content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0),
                      Divider(),
                      // 각 항목 사이의 간격 추가
                      Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 4), // 아이콘 사이의 간격 조절
                          Text(
                            posts[index].goodCount.toString(), // 좋아요 수
                          ),
                          SizedBox(width: 8), // 아이콘 사이의 간격 조절
                          SvgPicture.asset('asset/icons/comment.svg'),
                          SizedBox(width: 4), // 아이콘 사이의 간격 조절
                          Text(
                            posts[index].commentCount.toString(), // 댓글 수
                          ),
                          Spacer(), // 오른쪽으로 확장되는 공간을 만듭니다.
                          SvgPicture.asset('asset/icons/viewcount.svg'),
                          SizedBox(width: 4),
                          Text(
                            "14", // 조회 수
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailScreen(post : posts[index],boardName: widget.boardName)),
                    );
                    // 게시글을 눌렀을 때의 동작을 추가할 수 있습니다.
                  },
                ),
              ),
            );

          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        },
        controller: _scrollController,

      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WriteScreen(widget.boardId,widget.boardName)),
          );
          // 버튼을 눌렀을 때 수행할 작업을 추가할 수 있습니다.
        },
        child: SvgPicture.asset(
          'asset/icons/pencil.svg',
          width: 35,
          color: Colors.black,
        ),

      ),

    );
  }
  void _scrollListener() {
    if (isLoading) return;

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchPosts();
    }
  }
}
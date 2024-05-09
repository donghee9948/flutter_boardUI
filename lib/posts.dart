import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import '/navigation/navigationScreen.dart';
import '/write.dart';

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

    final response = await http.get(Uri.parse('http://59.12.23.92:8080/posts?page=$page&pageSize=$pageSize&boardId=${widget.boardId}'));
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
      appBar: AppBar(

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
            return GestureDetector(
              onTap: (){print(posts[index].content);},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF718096)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person,color: Color(0xFF7C3AED),)
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  posts[index].memberName,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                                Text(
                                  "숭실대학교, 컴퓨터학부",
                                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8),
                          child: Text(
                            posts[index].content,
                            style: TextStyle(fontSize: 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            IconButton(
                              icon: Icon(Icons.favorite,color: iconColor),
                              onPressed: (){
                                toggleFavorite();
                              },
                            ),

                            Text(
                              "1",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "댓글 14",
                              style: TextStyle(fontSize: 14),

                            ),
                            SizedBox(width: 12),
                            Text(
                              "조회수 26",
                              style: TextStyle(fontSize: 14),
                            )

                          ],
                        )

                      ],

                    ),
                  ),

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
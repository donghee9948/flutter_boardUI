import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen/posts.dart';


class DetailScreen extends StatefulWidget {
  final PostDto post;
  DetailScreen({required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              height: 1.0,
              thickness: 1.0,

            ),

          ),
          scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        child: Padding(

          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 글 내용 컨테이너
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Posted in Be전공자 지식나눔', //이 부분에 데이터 받아와야함(즐찾 가능한 커뮤니티, boardid)
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Divider(),
                    SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        SizedBox(width: 8.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.post.memberName,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('수원대학교 컴퓨터학부'
                            ),
                            SizedBox(height: 8.0,)
                          ],
                        )
                      ],
                    ),
                    Text(
                      widget.post.title,   //글 제목 넣기
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    Text(
                      widget.post.content
                    , //글 내용!
                      style: TextStyle(fontSize: 18.0),
                        ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 20.0),
              // Comment 글씨
              Text(
                'Comment',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              // 댓글 리스트
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: List.generate(12, (index) {
                      final memberId = '사용자${index + 1}'; // memberid
                      final comment = '${index + 1} 번째 댓글입니다.'; // comment

                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      memberId,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text('수원대학교 컴퓨터학부'),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.0),
                                Text(comment, style: TextStyle(fontSize: 16.0)),
                                SizedBox(height: 10.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Your onPressed logic here
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust the padding
                                        textStyle: TextStyle(fontSize: 12), // Adjust the font size
                                        minimumSize: Size(50, 30), // Adjust the minimum size
                                      ),
                                      child: Text('댓글(2)', style: TextStyle(color: Colors.black)), // Display the number of comments
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite, color: Colors.purple),
                                        ),
                                        Text(
                                          "3", // 좋아요 누른 숫자
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey),
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
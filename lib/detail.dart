import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen/posts.dart';



class CommentModel {
  final int goodCount;
  final DateTime commentDate;
  final int commentId;
  final int memberId;
  final int parentId;
  final int postId;
  final String content;

  CommentModel({
    required this.goodCount,
    required this.commentDate,
    required this.commentId,
    required this.memberId,
    required this.parentId,
    required this.postId,
    required this.content,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      goodCount: json['good_count'],
      commentDate: DateTime.parse(json['comment_date']),
      commentId: json['comment_id'],
      memberId: json['member_id'],
      parentId: json['parent_id'],
      postId: json['post_id'],
      content: json['content'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'good_count': goodCount,
      'comment_date': commentDate.toIso8601String(),
      'comment_id': commentId,
      'member_id': memberId,
      'parent_id': parentId,
      'post_id': postId,
      'content': content,
    };
  }

}

class DetailScreen extends StatefulWidget {
  final PostDto post;
  final String boardName;

  DetailScreen({required this.post, required this.boardName});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<bool> _isReplyVisible = List.generate(12, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
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
        body: SingleChildScrollView(
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
                      RichText(
                        text: TextSpan(
                          text: "Posted in ",
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                          children: [
                            TextSpan(
                              text: widget.boardName,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
                          SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post.memberName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('수원대학교 컴퓨터학부'),
                                SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (String value) {
                              // Handle the selected option here
                              if (value == 'edit') {
                                // Edit action
                              } else if (value == 'delete') {
                                // Delete action
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Text('수정'), // OnTap: 속성을 사용해서 write.dart 파일로 이동
                                  //이동하면 글쓰기 화면에 기존에 썻던 글 내용 나오게!
                                ),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('삭제'), // OnTap: 속성 사용해서 글 삭제
                                ),
                              ];
                            },
                            icon: Icon(Icons.more_vert),
                            color: Colors.white,

                          ),
                        ],
                      ),
                      Text(
                        widget.post.title, //글 제목 넣기
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                      Text(
                        widget.post.content, //글 내용!
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

                        // 대댓글 리스트
                        final List<String> replies = List.generate(
                          3,
                              (replyIndex) => '대댓글 ${replyIndex + 1}입니다.',
                        );

                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
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
                                          setState(() {
                                            _isReplyVisible[index] = !_isReplyVisible[index];
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          textStyle: TextStyle(fontSize: 12),
                                          minimumSize: Size(50, 30),
                                        ),
                                        child: Text(
                                          '댓글',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.favorite, color: Colors.purple),
                                          ),
                                          Text("3"), // 좋아요 누른 숫자
                                        ],
                                      ),
                                    ],
                                  ),
                                  // 대댓글 리스트 표시
                                  if (_isReplyVisible[index])
                                    ...replies.map((reply) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 20.0, top: 10.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.subdirectory_arrow_right, color: Colors.grey),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey, width: 1),
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                margin: EdgeInsets.only(left: 8.0),
                                                child: ListTile(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      vertical: 5.0, horizontal: 15.0),
                                                  title: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors.grey,
                                                        child: Icon(Icons.person,
                                                            color: Colors.white),
                                                      ),
                                                      SizedBox(width: 8.0),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '대댓글 사용자',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Text('대댓글 학부'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 16.0),
                                                      Text(reply,
                                                          style: TextStyle(fontSize: 14.0)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color(0xffffff),
            border: Border(
              top: BorderSide(color: Colors.grey, width: 1.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요.',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.black),  // Adjust the text color to be visible on white background
                  ),
                ),
                SizedBox(width: 6),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.purple),
                  onPressed: () {
                    // Add your send action here
                  },
                ),
              ],
            ),
          ),
        ),

    );
  }
}
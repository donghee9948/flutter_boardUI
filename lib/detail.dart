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
  bool isReplying = false;
  int? replyingToCommentIndex;

  List<bool> _isReplyVisible = List.generate(12, (index) => false);
  bool isLiked = false; // 글 좋아요 상태를 나타내는 변수 ,goodCount
  int likeCount = 3; // 글 좋아요 수

  List<bool> _commentLikes = List.generate(12, (index) => false); // 댓글 좋아요 상태
  List<int> _commentLikeCounts = List.generate(12, (index) => 3); // 댓글 좋아요 수

  List<List<bool>> _replyLikes = List.generate(12, (index) => List.generate(3, (replyIndex) => false)); // 대댓글 좋아요 상태
  List<List<int>> _replyLikeCounts = List.generate(12, (index) => List.generate(3, (replyIndex) => 3)); // 대댓글 좋아요 수

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
                                fontWeight: FontWeight.bold
                            ),
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
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post.memberName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('수원대학교 컴퓨터학부'),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (String value) {
                            // Edit 및 Delete 액션 처리
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
                                child: Text('수정'), // 수정 액션
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('삭제'), // 삭제 액션
                              ),
                            ];
                          },
                          icon: Icon(Icons.more_vert),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      widget.post.title, // 글 제목
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0
                      ),
                    ),
                    Text(
                      widget.post.content, // 글 내용
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '작성 시간: 2024-05-27', // 예시 작성 시간
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                                color: isLiked ? Colors.purple : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isLiked = !isLiked;
                                  if (isLiked) {
                                    likeCount++;
                                  } else {
                                    likeCount--;
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '좋아요 $likeCount', // 좋아요 수
                              style: TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                            SizedBox(width: 16.0),
                            Icon(Icons.visibility, color: Colors.grey, size: 16.0),
                            SizedBox(width: 4.0),
                            Text(
                              '조회 수 123', // 예시 조회 수
                              style: TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 20.0),
              // Comment 텍스트
              Text(
                'Comment',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
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
                    final memberId = '사용자${index + 1}'; // 사용자 ID
                    final comment = '${index + 1} 번째 댓글입니다.'; // 댓글 내용

                    // 대댓글 리스트
                    final List<String> replies = List.generate(
                      3,
                          (replyIndex) => '대댓글 ${replyIndex + 1}입니다.',
                    );

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 15.0
                          ),
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
                              Spacer(),
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  // Edit 및 Delete 액션 처리
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
                                      child: Text('수정'), // 수정 액션
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('삭제'), // 삭제 액션
                                    ),
                                  ];
                                },
                                icon: Icon(Icons.more_vert, color: Colors.grey),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("2024-05-27"), // 날짜 텍스트
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (isReplying && replyingToCommentIndex == index) {
                                          isReplying = false;
                                          replyingToCommentIndex = null;
                                        } else {
                                          isReplying = true;
                                          replyingToCommentIndex = index;
                                        }
                                        _isReplyVisible[index] = !_isReplyVisible[index];
                                      });
                                    },
                                    icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
                                  ),
                                  Text('3'),
                                  SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(
                                      _commentLikes[index] ? Icons.favorite : Icons.favorite_border_outlined,
                                      color: _commentLikes[index] ? Colors.purple : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _commentLikes[index] = !_commentLikes[index];
                                        if (_commentLikes[index]) {
                                          _commentLikeCounts[index]++;
                                        } else {
                                          _commentLikeCounts[index]--;
                                        }
                                      });
                                    },
                                  ),
                                  Text("${_commentLikeCounts[index]}"), // 좋아요 숫자
                                ],
                              ),
                              // 대댓글 리스트 표시
                              if (_isReplyVisible[index])
                                ...replies.map((reply) {
                                  int replyIndex = replies.indexOf(reply);
                                  return Padding(
                                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(Icons.person, color: Colors.white),
                                                  radius: 16,
                                                ),
                                                SizedBox(width: 8.0),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '사용자',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      '수원대학교 컴퓨터학부',
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                PopupMenuButton<String>(
                                                  onSelected: (String value) {
                                                    // Edit 및 Delete 액션 처리
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
                                                        child: Text('수정'), // 수정 액션
                                                      ),
                                                      PopupMenuItem<String>(
                                                        value: 'delete',
                                                        child: Text('삭제'), // 삭제 액션
                                                      ),
                                                    ];
                                                  },
                                                  icon: Icon(Icons.more_vert, color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.0),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isReplying = true;
                                                  replyingToCommentIndex = index;
                                                });
                                              },
                                              child: Text(
                                                reply,
                                                style: TextStyle(fontSize: 14.0),
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      _replyLikes[index][replyIndex] ? Icons.favorite : Icons.favorite_border_outlined,
                                                      color: _replyLikes[index][replyIndex] ? Colors.purple : Colors.grey,

                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _replyLikes[index][replyIndex] = !_replyLikes[index][replyIndex];
                                                        if (_replyLikes[index][replyIndex]) {
                                                          _replyLikeCounts[index][replyIndex]++;
                                                        } else {
                                                          _replyLikeCounts[index][replyIndex]--;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "${_replyLikeCounts[index][replyIndex]}",
                                                    style: TextStyle(fontSize: 12.0), // 텍스트 크기 조정
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
              ),
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
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: isReplying ? '대댓글을 입력하세요.' : '댓글을 입력하세요.',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 6),
              IconButton(
                icon: Icon(Icons.send, color: Colors.purple),
                onPressed: () {
                  // Add your send action here
                  if (isReplying && replyingToCommentIndex != null) {
                    // 대댓글 작성 로직
                    // replyingToCommentIndex를 사용하여 대댓글을 작성할 댓글을 식별할 수 있습니다.
                  } else {
                    // 댓글 작성 로직
                  }
                  setState(() {
                    isReplying = false;
                    replyingToCommentIndex = null;
                    _commentController.clear();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}




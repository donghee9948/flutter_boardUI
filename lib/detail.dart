import 'package:flutter/material.dart';


class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16.0),
                child: Text(
                  // 여기에 글 내용을 적어주세요. 길어질 경우 스크롤 가능합니다.
                  '이것은 플러터로 만든 글 내용입니다. 글이 매우 길어 스크롤해서 읽을 수 있습니다.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 20.0), // 공간 추가
              // Comment 글씨
              Text(
                'Comment',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0), // 공간 추가
              // 댓글 리스트
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white, // 하얀색 배경
                ),
                height: 300.0, // 댓글이 많을 경우 스크롤 가능하도록 높이 지정
                child: ListView(
                  // 댓글 목록 추가
                  children: [
                    ListTile(
                      title: Text('사용자1'),
                      subtitle: Text('첫 번째 댓글입니다.'),
                    ),
                    ListTile(
                      title: Text('사용자2'),
                      subtitle: Text('두 번째 댓글입니다.'),
                    ),
                    ListTile(
                      title: Text('사용자3'),
                      subtitle: Text('세 번째 댓글입니다.'),
                    ),
                    // 필요한 만큼 댓글을 추가할 수 있습니다.
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
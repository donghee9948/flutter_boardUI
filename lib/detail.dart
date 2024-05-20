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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Posted in Be전공자 지식나눔', //이 부분에 데이터 받아와야함
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
                            Text('김태민'),
                            Text('수원대학교, 컴퓨터학부'
                            ),
                            SizedBox(height: 8.0,)
                          ],
                        )
                      ],
                    ),
                    Text(
                      "Finally 블록에서 예외가 발생하면 어떻게 되나요?",   //글 제목 넣기
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
                    ),
                    Text(
                    "자바에서, try-catch에서 finally 블록 내에서 예외가 발생할 때의 동작은, try-catch 블록의 예외 처리와 약간 "
                        "다릅니다.  [Try-Catch 블록의 예외]정상적인 플로우가 중지됩니다"
                        ".예외 유형과 일치하는 catch 블록이 있다면, 해당 블록 내의 코드가 실행됩니다. 이를"
                        " 통해 예외를 처리할 수 있습니다.catch 블록이 완료되거나 어떤 catch 블"
                        "록과도 일치하지 않으면 finally 블록의 코드가 실행됩니다.[Finally 블록의 예외]원래의 예외가 중지됩니다. 이는 원래의 예"
                        "외가 메서드 호출자에게 전달되지 않는 것을 의미합니다.finally 블록에서 던진 예외가 호출자에게전달되지 않는 것을 의미합니다.finally 블록에서 던진 "
                        "예외가 호출자에게 전파되는 새로운 예외가 됩니다.", //글 내용!
                      style: TextStyle(fontSize: 18.0),
                        )
                  ],
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
                  children: [
                    ListTile(
                      title: Text('사용자1'), //memberid 넣으면댐
                      subtitle: Text('첫 번째 댓글입니다.'),  //comment 넣으면댐
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
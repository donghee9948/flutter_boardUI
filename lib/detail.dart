import 'package:flutter/material.dart';


class DetailScreen extends StatefulWidget {
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0
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
                            Text('김태민',style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('수원대학교 컴퓨터학부'
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
              SizedBox(height: 20.0),
              // Comment 글씨
              Text(
                'Comment',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              // 댓글 리스트
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                height: 300.0,
                child: ListView.separated(
                  itemCount: 3, // commet 갯수!
                  itemBuilder: (context, index) {
                    final memberId = '사용자${index + 1}'; //  memberid
                    final comment = '${index + 1} 번째 댓글입니다.'; // comment

                    return ListTile(
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
                              Text(memberId, style: TextStyle(fontWeight: FontWeight.bold),  //memberid 대입
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
                          Text(comment, style: TextStyle(fontSize: 16.0)),   //댓글 내용 대입
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
                                child: Text('댓글(2)',style: TextStyle(color: Colors.black),), // Display the number of comments
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                },

                                icon: Icon(Icons.favorite, color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
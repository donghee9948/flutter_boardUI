import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class BoardData {
  final String boardName;

  BoardData({required this.boardName});

  factory BoardData.fromJson(Map<String, dynamic> json) {
    return BoardData(
      boardName: json['boardName'],
    );
  }
}

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}






class _BoardState extends State<Board> {
  int _currentPageIndex=0;
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
    fetchBoards();
  }

  late List<BoardData> boardss = [];

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }
  Future<void> fetchBoards() async {
    final response = await http.get(Uri.parse('http://116.47.60.159:8080/board'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        boardss = jsonData.map((data) => BoardData.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load posts');

    }
  }


  PreferredSizeWidget _appbarWidget(){
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Text('커뮤니티',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(onPressed: () {},
              icon:  SvgPicture.asset('asset/icons/search.svg',width: 30,height: 30,),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(onPressed: () {},
              icon: SvgPicture.asset('asset/icons/bell.svg',width: 30,height: 30,),),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Color(0xFF999999),
            height: 1.0,
          ),
        )
    );
  }









  Widget _bodyWidget() {

    bool isFavorite = false;

    void toggleFavorite() {
      setState(() {
        isFavorite = !isFavorite;
      });
    }


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Container(


              height: 200,
              width: 341,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFADB5BD),width: 1)
                  )
              ),
              child: ListView(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: SvgPicture.asset('asset/icons/list.svg',width: 30,height: 30,),
                    title: Text('내가 쓴 글', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),),
                    onTap: (){print('내가 쓴글');},
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: SvgPicture.asset('asset/icons/chat.svg',width: 30,height: 30,),
                    title: Text('댓글 단 글', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),),
                    onTap: (){print('댓글 단 글');},
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: SvgPicture.asset('asset/icons/good.svg',width: 30,height: 30,),
                    title: Text('좋아요 누른 글', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),),
                    onTap: (){print('좋아요 누른 글');},
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: SvgPicture.asset('asset/icons/fire.svg',width: 30,height: 30,),
                    title: Text('HOT 게시글', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),),
                    onTap: (){print('HOT 게시글');},
                  ),
                ],
              ),
            ),
          ),
        ),

        Container(
          height: 300,
          width: 355,

          child: ListView.builder(
              itemCount: boardss.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  leading: IconButton(
                    icon: Icon(Icons.star),
                    onPressed: () {

                    },
                  ),
                  title: Text(
                    boardss[index].boardName,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    // 게시판을 선택했을 때의 동작을 추가할 수 있습니다.

                  },
                );
              }),

        )
      ],

    );
  }







  BottomNavigationBarItem _bottomNavigationBarItem(String iconName,  String label){
    return      BottomNavigationBarItem(
      icon: SvgPicture.asset('asset/icons/${iconName}.svg'),
      activeIcon: SvgPicture.asset('asset/icons/${iconName}.svg',color: Color(0xFF7C3AED),),
      label: label,
    );

  }

  Widget _bottomNavigationBarWidget(){
    int _selectedIndex = 0;


    return BottomNavigationBar(
      onTap: (int index){
        print(index);
        setState(() {
          _currentPageIndex=index;


        });
      },
      currentIndex: _currentPageIndex,



      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Color(0xFF7C3AED)),
      items: [
        _bottomNavigationBarItem("home",  "홈"),
        _bottomNavigationBarItem("board",  "게시판"),
        _bottomNavigationBarItem("group",  "친구목록"),
        _bottomNavigationBarItem("botchat",  "채팅"),
        _bottomNavigationBarItem("mypage",  "프로필"),
      ]
      ,);
  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        body: _bodyWidget(),
        bottomNavigationBar: _bottomNavigationBarWidget()

    );
  }
}
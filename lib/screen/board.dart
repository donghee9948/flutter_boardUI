import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class navigtionScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<navigtionScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Board3(),
    ChatScreen(),
    MypageScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[

            BottomNavigationBarItem(

              icon: SvgPicture.asset('asset/icons/home.svg'),
              activeIcon: SvgPicture.asset('asset/icons/home.svg',color: Color(0xFF7C3AED),),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('asset/icons/board.svg'),
              activeIcon: SvgPicture.asset('asset/icons/board.svg',color: Color(0xFF7C3AED),),
              label: '커뮤니티',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('asset/icons/group.svg'),
              activeIcon: SvgPicture.asset('asset/icons/group.svg',color: Color(0xFF7C3AED),),
              label: '그룹관리',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('asset/icons/botchat.svg'),
              activeIcon: SvgPicture.asset('asset/icons/botchat.svg',color: Color(0xFF7C3AED),),
              label: '채팅',
            ),BottomNavigationBarItem(
              icon: SvgPicture.asset('asset/icons/mypage.svg'),
              activeIcon: SvgPicture.asset('asset/icons/mypage.svg',color: Color(0xFF7C3AED),),
              label: '마이페이지',
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff7C3AED),
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}


class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ChatScreen Screen'),
    );
  }
}
class MypageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('MypageScreen Screen'),
    );
  }
}


class Board3 extends StatefulWidget {
  const Board3({super.key});

  @override
  State<Board3> createState() => _BoardState();
}


class _BoardState extends State<Board3> {
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
    final response = await http.get(Uri.parse('http://112.168.45.227:8080/board'));
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
      icon: SvgPicture.asset('assets/icons/${iconName}.svg'),
      activeIcon: SvgPicture.asset('assets/icons/${iconName}.svg',color: Color(0xFF7C3AED),),
      label: label,
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}

class BoardData {
  final String boardName;

  BoardData({required this.boardName});

  factory BoardData.fromJson(Map<String, dynamic> json) {
    return BoardData(
      boardName: json['boardName'],
    );
  }
}
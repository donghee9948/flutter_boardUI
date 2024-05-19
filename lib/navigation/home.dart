import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeAppBar()

    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('asset/image/logo.png'),
        ),
        title: Container(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요.',
              hintStyle: TextStyle(color: Colors.white),
              fillColor: Colors.black,
              filled: true,
              prefixIcon: Icon(Icons.search,color: Colors.white,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset('asset/icons/bell.svg'),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40, // 버튼 컨테이너의 높이 설정
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(114,28)
                      ),
                      child: Text('버튼 ${index + 1}',style: TextStyle(color: Colors.white),),

                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: Center(child: Text('HomeScreen')),
          ),
        ],
      ),
    );
  }
}
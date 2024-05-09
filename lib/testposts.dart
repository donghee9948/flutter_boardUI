import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splash_screen/navigation/navigationScreen.dart';
import '/posts.dart';


class testposts extends StatefulWidget {
  const testposts({super.key});

  @override
  State<testposts> createState() => _testpostsState();
}



class _testpostsState extends State<testposts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 1,
        
        title: Text("자유 게시판",textAlign: TextAlign.left,),
        leading: IconButton(icon:Icon(Icons.arrow_back),onPressed: null,),
        actions: [
          IconButton(icon: SvgPicture.asset('asset/icons/search.svg',width: 30,height: 30,),onPressed: null),
        ],
      )
      ,

    );
  }


}





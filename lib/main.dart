import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen/screen/board.dart';

void main() {
  runApp(
      MaterialApp(
        home: navigtionScreen(),
      ),
  );
}







class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text('게시판',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(onPressed: () {},
                  icon: Image.asset(
                    'asset/image/search.png', width: 24, height: 24,)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(onPressed: () {},
                  icon: Image.asset(
                    'asset/image/bell.png', width: 24, height: 24,)),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Color(0xFF999999),
              height: 1.0,
            ),
          )
      ),
    );
  }
}







class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///7C3AED
        backgroundColor: Color(0xFF7C3AED),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('asset/image/logo.png'
              ),
              SizedBox(height: 28.0,),
              CircularProgressIndicator(
                color: Colors.white,
              ),

            ],
          ),
        )
    );
  }
}




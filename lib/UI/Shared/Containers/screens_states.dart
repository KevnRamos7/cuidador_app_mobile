import 'package:flutter/material.dart';

class ScreenStates{

  Widget loadingScreen(){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          ),
           Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/img/introductions/isotipo.png',
                    width: 60,
                    height: 60,
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }

}
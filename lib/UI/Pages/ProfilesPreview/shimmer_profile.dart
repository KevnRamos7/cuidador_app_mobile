import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShimmerProfile{

  Widget shimmerContenedor(){
    return Material(
      child: Container(
        height: Get.height * 0.9,
        width: Get.width,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              const FadeShimmer(
                width: 200,
                height: 30,
                radius: 20,
                baseColor: Colors.black87, 
                fadeTheme: FadeTheme.light
              ),

              const FadeShimmer(
                width: 130,
                height: 20,
                radius: 20,
                baseColor: Colors.grey, 
                fadeTheme: FadeTheme.light
              ),
                
              FadeShimmer.round(
                size: 150,
                baseColor: Colors.grey, 
                fadeTheme: FadeTheme.light,
              ),

              const FadeShimmer(
                width: 200,
                height: 20,
                radius: 20,
                baseColor: Colors.grey, 
                fadeTheme: FadeTheme.light
              ),

              const FadeShimmer(
                width: 270,
                height: 20,
                radius: 20,
                baseColor: Colors.grey, 
                fadeTheme: FadeTheme.light
              ),

              const FadeShimmer(
                width: 240,
                height: 20,
                radius: 20,
                baseColor: Colors.grey, 
                fadeTheme: FadeTheme.light
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeShimmer.round(
                    size: 30,
                    baseColor: Colors.grey, 
                    fadeTheme: FadeTheme.light,
                  ),
                  FadeShimmer.round(
                    size: 30,
                    baseColor: Colors.grey, 
                    fadeTheme: FadeTheme.light,
                  ),
                  FadeShimmer.round(
                    size: 30,
                    baseColor: Colors.grey, 
                    fadeTheme: FadeTheme.light,
                  ),
                  FadeShimmer.round(
                    size: 30,
                    baseColor: Colors.grey, 
                    fadeTheme: FadeTheme.light,
                  ),
                  FadeShimmer.round(
                    size: 30,
                    baseColor: Colors.grey, 
                    fadeTheme: FadeTheme.light,
                  ),
                ],
              ),

              FadeShimmer(
                width: Get.width * 0.9,
                height: Get.height * 0.3,
                radius: 20,
                baseColor: Colors.grey, 
                fadeTheme: FadeTheme.light
              ),
                
            ],
          ),
        ),
      ),
    );
  }

}
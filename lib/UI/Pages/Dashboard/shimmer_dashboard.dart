import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShimmerDashboard{

  Widget contenidoCarga(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            FadeShimmer(
              highlightColor: Colors.grey[350],
              baseColor: Colors.grey[300],
              fadeTheme: FadeTheme.light,
              height: 20,
              width: Get.width * 0.8,
              radius: 10,
            ),
            const SizedBox(height: 10), 
            FadeShimmer(
              highlightColor: Colors.grey[350],
              baseColor: Colors.grey[300],
              fadeTheme: FadeTheme.light,
              height: 20,
              width: Get.width * 0.8,
              radius: 10,
            ),
            const SizedBox(height: 30),
            FadeShimmer(
              highlightColor: Colors.grey[350],
              baseColor: Colors.grey[300],
              fadeTheme: FadeTheme.light,
              height: 20,
              width: Get.width * 0.8,
              radius: 10,
            ),
        
            const SizedBox(height: 30),
        
            FadeShimmer(
              highlightColor: Colors.grey[350],
              baseColor: Colors.grey[300],
              fadeTheme: FadeTheme.light,
              height: 200,
              width: Get.width * 0.9,
              radius: 10,
            ),
        
            const SizedBox(height: 30),
        
            FadeShimmer(
              highlightColor: Colors.grey[350],
              baseColor: Colors.grey[300],
              fadeTheme: FadeTheme.light,
              height: 200,
              width: Get.width * 0.9,
              radius: 10,
            ),
        
          ],
        ),
      ],
    );
  }

}
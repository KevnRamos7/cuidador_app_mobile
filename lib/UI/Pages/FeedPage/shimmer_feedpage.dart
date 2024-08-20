import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShimmerFeedpage{

  Widget shimmerContenedor(){
    return Material(
      child: SizedBox(
        height: Get.height * 0.65,
        width: Get.width,
        child: SafeArea(
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9
            ),
            itemBuilder: (context, index){
              return const FadeShimmer(
                width: 200,
                height: 100,
                radius: 20,
                baseColor: Colors.grey, 
                fadeTheme: FadeTheme.light
              );
            }
          )
        ),
      ),
    );
  }

}
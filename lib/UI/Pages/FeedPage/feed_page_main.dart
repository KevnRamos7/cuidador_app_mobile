import 'package:cuidador_app_mobile/UI/Pages/FeedPage/Models/feed_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/FeedPage/Modules/feed_grid_view.dart';
import 'package:cuidador_app_mobile/UI/Pages/FeedPage/Modules/filter_bar_nav.dart';
import 'package:cuidador_app_mobile/UI/Pages/FeedPage/shimmer_feedpage.dart';
import 'package:cuidador_app_mobile/UI/Shared/BottomNavigation/bottom_navigation_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedPageMain extends StatelessWidget {
  FilterBarNav filterBarNav = Get.put(FilterBarNav());
  FeedGridView feedGridView = Get.put(FeedGridView());
  FeedController con = Get.put(FeedController());
  ShimmerFeedpage shimmerFeedpage = Get.put(ShimmerFeedpage());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FocusScope(
        node: FocusScopeNode(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: RefreshIndicator(
            onRefresh: () async {
              await con.setPerfilesCuidadores();
              con.buscarCuidador('');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                filterBarNav.topNavigation(),
                Obx(()=>
                  con.isLoading.value == true ? 
                      shimmerFeedpage.shimmerContenedor() 
                    :
                    feedGridView.feedGridView()
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
    );
  }
}
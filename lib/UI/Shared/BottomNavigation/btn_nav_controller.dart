import 'package:get/get.dart';

class BtnNavController extends GetxController{

  RxInt index = 0.obs;

  void setIndex(int newIndex){
    index.value = newIndex;
  }

}
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController{

  TextEditingController reviewController = TextEditingController();

  Rx<ContratoModel> contrato = ContratoModel().obs;

}
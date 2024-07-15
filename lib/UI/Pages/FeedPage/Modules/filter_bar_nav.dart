import 'package:cuidador_app_mobile/UI/Shared/TextFields/search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBarNav{

  SearchTextfield searchComponent = Get.put(SearchTextfield());

  Widget topNavigation(){
    return Container(
      height: Get.height * 0.25,
      width:double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 1,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ]
      ),
      child: SafeArea(
        // minimum: const EdgeInsets.all(16),
        bottom: false,
        child: Column(
          children: [
            searchComponent.searchTextField(
              hintText: 'Nombre, Certificaciones, Horarios, Genero ...',
              icon: CupertinoIcons.search,
              onChanged: (value) => {},
            ),
            _scrollIconsFilter(),
          ],
        ),
      ),
    );
  }

  Widget _scrollIconsFilter(){
    return SizedBox(
      height: Get.height * 0.075,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _filterIcon(icon: CupertinoIcons.money_dollar_circle, text: 'Rango de Precio'),
          _filterIcon(icon: CupertinoIcons.location_solid, text: 'Cerca de mi'),
          _filterIcon(icon: CupertinoIcons.calendar_circle, text: 'Horarios'),
          _filterIcon(icon: CupertinoIcons.star, text: 'Calificación'),
          _filterIcon(icon: CupertinoIcons.doc_text_viewfinder, text: 'Certificaciones'),
          _filterIcon(icon: CupertinoIcons.person_crop_square, text: 'Género'),
        ],
      ),
    );
  }

  Widget _filterIcon({required IconData icon, required String text}){
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16, top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: const Color(0xFFA6A6A6), size: Get.height * 0.035,),
          Text(text, style: GoogleFonts.roboto(color: const Color(0xFFA6A6A6), fontSize: 11),)
        ],
      ),
    );
  }

}
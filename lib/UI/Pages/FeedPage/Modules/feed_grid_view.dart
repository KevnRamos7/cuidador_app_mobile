import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/format_money_number.dart';
import 'package:cuidador_app_mobile/UI/Pages/FeedPage/Models/feed_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedGridView{
  FeedController con = Get.put(FeedController());
  FormatMoneyNumber money = FormatMoneyNumber();

  Widget feedGridView(){
    return Expanded(
      child: Obx(()=>
        GridView.builder(
          itemCount: con.cuidadoresListSearch.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index){
            return itemForGrid(usuario: con.cuidadoresListSearch[index]);
          },
        ),
      ),
    );
  } 

  Widget itemForGrid({
    required UsuarioModel usuario
  }){
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.25,
          width: Get.width * 0.45,
          child: Stack(
            children: [

              Positioned(
                left: 0,
                top: 23.53,
                child: Container(
                  width: Get.width * 0.45,
                  height: Get.height * 0.2,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: Get.height * 0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            '${usuario.persona!.first.nombre.toString()} ${usuario.persona!.first.apellidoMaterno.toString()}', 
                              style: const TextStyle(fontWeight: FontWeight.bold), 
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Text(usuario.nivelUsuario ?? '', style: const TextStyle(fontWeight: FontWeight.w300)),
                            Text('Costo: ${money.formatCurrencyInMXN(usuario.salarioCuidador ?? 0)} /h.', style: const TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: Get.height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 15 * (usuario.comentariosUsuario?.isNotEmpty == true ? usuario.comentariosUsuario!.map((c) => c.calificacion!.toDouble()).reduce((a, b) => a + b) / usuario.comentariosUsuario!.length : 1),
                                child: ListView.builder(
                                  itemCount: (usuario.comentariosUsuario?.isNotEmpty == true ? usuario.comentariosUsuario!.map((c) => c.calificacion!.toDouble()).reduce((a, b) => a + b) / 5 : 1).toInt(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return const Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 15,);
                                  },
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: OvalBorder(),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F115A6A),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () => con.generatedContrato(usuario),
                                child: const Icon(CupertinoIcons.doc_plaintext, color: Colors.black, size: 15,))
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          
              Positioned(
                left: 0,
                top: 23.53,
                child: Container(
                  width: Get.width * 0.45,
                  height: Get.height * 0.09,
                  decoration: ShapeDecoration(
                    color: usuario.persona!.first.colorBg ?? Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
          
              Positioned(
                left: (Get.width * 0.45 - Get.width * 0.2) / 2,
                top: 0,
                child: GestureDetector(
                  onTap: () => Get.toNamed('/previewProfileCuidador', arguments: usuario.idUsuario),
                  child: Container(
                    width: Get.width * 0.2,
                    height: 76.69,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(usuario.persona?.first.avatarImage ?? '', 
                        width: 150, height: 150, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Image(image: AssetImage('assets/img/shared/avatar_default.jpg'), width: 150, height: 150, fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
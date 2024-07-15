// ignore_for_file: must_be_immutable

import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/resumen_cont_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumenContPageMain extends StatelessWidget {
  // const ResumenContPageMain({super.key});
  ResumenContController con = Get.put(ResumenContController());

  ResumenContPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cuidadorCard(),
              
                  encabezado('Fechas y Horarios'),
              
                  tableForSchedules(),
              
                  encabezado('Lista de Tareas'),
              
                  tableForTask(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      btnAction('Confirmar', (){}, const Color.fromARGB(255, 4, 48, 110)),
                      btnAction('Cancelar', (){}, const Color.fromARGB(255, 220, 74, 63)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget btnAction(String titulo, Function() onPressed, Color color){
    return Container(
      width: Get.width * 0.3,
      height: Get.height * 0.05,
      margin: EdgeInsets.only(bottom: Get.height * 0.06, top: Get.height * 0.04),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)
      ),
    );
  }

  Widget encabezado(String title){
    return Container(
      margin: EdgeInsets.only(top:  Get.height * 0.06, bottom: Get.height * 0.02),
      width: Get.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 114, 114, 114)), textAlign: TextAlign.start,),
        ],
      ),
    );
  }

  Widget tableForTask(){
    return SizedBox(
      // height: Get.height * 0.3,
      width: Get.width * 0.95,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.grey[100]!),
        headingRowHeight: 40,
        border: TableBorder.all(color: Colors.grey, width: 0.5, borderRadius: BorderRadius.circular(10)),

        columns: const [
          DataColumn(label: Text('Tarea', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Hora', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(Text('Salir a dar un paseo en el parque', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
              DataCell(Text('8:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
            ]
          ),
          DataRow(
            cells: [
              DataCell(Text('Realizar tareas de limpieza en su habitación', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
              DataCell(Text('10:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
            ]
          ),
          DataRow(
            cells: [
              DataCell(Text('Dar medicamento para la diabetes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
              DataCell(Text('12:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
            ]
          )
        ],
      ),
    );
  }

  Widget tableForSchedules(){
    return SizedBox(
      // height: Get.height * 0.3,
      width: Get.width * 0.95,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.grey[100]!),
        headingRowHeight: 40,
        border: TableBorder.all(color: Colors.grey, width: 0.5, borderRadius: BorderRadius.circular(10)),

        columns: const [
          DataColumn(label: Text('Fecha', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Horario', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(Text('23 de Abril de 2024', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
              DataCell(Text('8:00 - 12:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
            ]
          ),
          DataRow(
            cells: [
              DataCell(Text('23 de Abril de 2024', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
              DataCell(Text('8:00 - 12:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
            ]
          ),
          DataRow(
            cells: [
              DataCell(Text('23 de Abril de 2024', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
              DataCell(Text('8:00 - 12:00', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)),
            ]
          )
        ],
      ),
    );
  }

  Widget cuidadorCard(){
    return SizedBox(
      height: Get.height * 0.25,
      width: Get.width * 0.9,
      child: Stack(
        children: [
          Container(
            height: Get.height * 0.25,
            width: Get.width * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                    SizedBox(
                      height: Get.height * 0.04,
                      child: Text(
                        con.contrato.value.personaCuidador!.nombre ?? '',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ), 
                                 ),
                    ),
                   ],
                 ),
          
                SizedBox(
                  // color: Colors.amber,
                  height: Get.height * 0.08,
                  width: Get.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            
                      const Text(
                        'Certificaciones',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                      ),
                            
                      Text(
                        con.contrato.value.personaCuidador!.certificaciones![0].tipoCerficacion ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black
                        ),
                      ),
                            
                      Text(
                        con.contrato.value.personaCuidador!.certificaciones![0].tipoCerficacion ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black
                        ),
                      )
                            
                    ],
                  ),
                ),
          
                SizedBox(
                  // color: Colors.amber,
                  height: Get.height * 0.05,
                  width: Get.width * 0.9,
                  child: Row(
                    children: [
          
                      SizedBox(
                        height: Get.height * 0.05,
                        width: Get.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Calificación',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                             ),
                      
                            Expanded(
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return const Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 15,);
                                },
                              ),
                            ),
          
                          ],
                        ),
                      ),
          
                      SizedBox(
                        height: Get.height * 0.05,
                        width: Get.width * 0.4,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                             Text(
                              'Cuidados Realizados',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                            ),
                      
                            Text(
                              '101 CUIDADOS',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey
                              ),
                            ) 
                          ],
                        ),
                      )
          
                    ],
                  ),
                )
          
              ],
            )
          ),

          Positioned(
            left: Get.width * 0.69,
            top: 5,
            child: Container(
              width: Get.width * 0.2,
              height: 76.69,
              decoration: ShapeDecoration(
                image: const DecorationImage(image: AssetImage('assets/img/testing/profile_image_test.png'), fit: BoxFit.fill),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}
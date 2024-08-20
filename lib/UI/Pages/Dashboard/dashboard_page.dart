import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/Dashboard/Models/dashboard_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/Dashboard/shimmer_dashboard.dart';
import 'package:cuidador_app_mobile/UI/Shared/BottomNavigation/bottom_navigation_main.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/calendar_container.dart';
import 'package:d_chart/d_chart.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardPage extends StatelessWidget {
  // const DashboardPage({super.key});
  LetterDates letterDates = LetterDates();
  CalendarContainer calendar = Get.put(CalendarContainer());
  DashboardController controller = Get.put(DashboardController());
  ShimmerDashboard shimmer = Get.put(ShimmerDashboard());

  @override
  Widget build(BuildContext context) {
    final timeGroupList = [
        TimeGroup(
            id: '1',
            data: controller.timeDataList,
        ),
    ];

    double progressContrato = 0;

    switch(controller.contratoEnCurso?.value.estatus?.idEstatus ?? 0){
      case 18:
        progressContrato = 150;
        break;
      case 7:
        progressContrato = 200;
        break;
      case 19:
        progressContrato = 250;
        break;
      case 9:
        progressContrato = 300;
        break;
      default:
        progressContrato = 0;
    }

    return Scaffold(
      body: SafeArea(
        child: Obx(()=>
          controller.isLoad.value == true ? shimmer.contenidoCarga() :
          SingleChildScrollView(
            child: Column(
              children: [
                _encabezado(),
          
                Container(
                  height: Get.height * 0.3,
                  width: Get.width * 0.9,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 30,
                        offset: Offset(0, 5),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      selectableDayPredicate: (DateTime dateTime) {
                        return false;
                      },
                      disabledDayTextStyle: const TextStyle(color: Colors.grey),
                      calendarType: CalendarDatePicker2Type.multi,
                      daySplashColor: Colors.white,
                      selectedDayHighlightColor: const Color.fromARGB(255, 9, 87, 151),
                      selectedRangeHighlightColor: const Color.fromARGB(255, 176, 230, 255).withOpacity(0.5),
                      selectedDayTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: controller.fechasContratos,
                    onValueChanged: (value) {
                    },
                  ),
                ),
                
                _largeBlock(
                  title: 'Estadisticas',
                  subtitle: 'Mes y horas de cuidados',
                  contenido: Expanded(
                    child: AspectRatio(aspectRatio: 16/9,
                      child: DChartLineT(
                        groupList: timeGroupList,
                      ),
                    )
                  ),
                ),
          
                _largeBlock(
                  title: 'Ultimo contrato',
                  subtitle: 'Estatus del contrato',
                  subtitle2: letterDates.formatearSoloFecha(controller.contratoEnCurso?.value.horarioInicioPropuesto.toString() ?? ''),
                  contenido: SizedBox(
                    height: Get.height * 0.2,
                    width: Get.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(letterDates.formatearSoloFecha(controller.contratoEnCurso?.value.horarioInicioPropuesto.toString() ?? ''), 
                        style: const TextStyle(fontSize: 15, color: Colors.black54),),
                        SizedBox(
                          height: Get.height * 0.15,
                          child: AspectRatio(
                            aspectRatio: 10 / 7,
                            child: DashedCircularProgressBar.square(
                              dimensions: 150,
                              progress: progressContrato,
                              maxProgress: 360,
                              startAngle: -27.5,
                              foregroundColor: Colors.redAccent,
                              backgroundColor: const Color(0xffeeeeee),
                              foregroundStrokeWidth: 7,
                              backgroundStrokeWidth: 7,
                              foregroundGapSize: 10,
                              foregroundDashSize: 55,
                              backgroundGapSize: 5,
                              backgroundDashSize: 55,
                              animation: true,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                                size: 70
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
          
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
    );
  } 

  Widget _encabezado(){
    PersonaModel persona = PersonaModel.fromJson(GetStorage().read('perfil'));
    return Container(
      height: Get.height * 0.2,
      width: Get.width,
      // color: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hola de nuevo, ${persona.nombre ?? ''}', 
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
          Text(letterDates.formatearFecha(DateTime.now().toString()), style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 30,),
          const Text('Estas son tus estadisticas al día de hoy', style: TextStyle(fontSize: 15, color: Colors.black54),),
        ],
      ),
    );
  }

  Widget _largeBlock({required String title, required String subtitle, required Widget contenido, String? subtitle2}){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      height: Get.height * 0.3,
      width: Get.width * 0.9,
      decoration: ShapeDecoration(
        color: const Color(0xFFF9F9F9),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFF919191),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Get.height * 0.05,
            decoration: const BoxDecoration(
              color: Color(0xFFF9F9F9),
              border: Border(
                bottom: BorderSide(
                  width: 0.50,
                  color: Color(0xFF919191),
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),),
                ),
              ],
            ),
          ),

          contenido,
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54),),
              ),
              subtitle2?.isEmpty == true ? const SizedBox() : Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(subtitle2 ?? '', style: const TextStyle(fontSize: 13, color: Colors.black54),),
              ),
            ],
          )

        ],
      ),
    );
  }

}
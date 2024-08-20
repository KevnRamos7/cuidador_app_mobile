import 'package:cuidador_app_mobile/Data/Response/Home/HomeResponse.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/dasboard.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{

  HomeResponse homeResponse = HomeResponse();
  SnackbarUI snackbarUI = SnackbarUI();

  List<TimeData> timeDataList = [
  ];

  List<DateTime> fechasContratos = [
  ];

  Rx<ContratoItemModel>? contratoEnCurso = ContratoItemModel().obs;

  RxBool isLoad = false.obs;

  @override
  void onInit() {
    getDashboard();
    super.onInit();
  }

  Future<void> getDashboard() async{
    isLoad.value = true;
    try{
      Dasboard dashboard = await homeResponse.getDashboard();
      for(var item in dashboard.horasPorMes!){
        timeDataList.add(TimeData(domain: DateTime(2024, convertirMesALetra(item.mes!), 1), measure: item.horas!.toDouble()));
      }

      if(dashboard.fechasConContratos == null){
        isLoad.value = false;
        return;
      }

      for(var item in dashboard.fechasConContratos!){
        fechasContratos.add(item.horarioInicioPropuesto!);
      }
      contratoEnCurso = dashboard.contratoEnCurso?.obs;
    }
    catch(e){
      isLoad.value = false;
      // snackbarUI.snackbarError('Ha Ocurrido un Error!', 'Error al cargar el dashboard');
    }
    isLoad.value = false;
  }

  int convertirMesALetra(String mes) {
    Map<String, int> meses = {
      'enero': 1,
      'febrero': 2,
      'marzo': 3,
      'abril': 4,
      'mayo': 5,
      'junio': 6,
      'julio': 7,
      'agosto': 8,
      'septiembre': 9,
      'octubre': 10,
      'noviembre': 11,
      'diciembre': 12,
    };

  return meses[mes.toLowerCase()] ?? -1;  // Retorna -1 si el mes no es válido
}


}
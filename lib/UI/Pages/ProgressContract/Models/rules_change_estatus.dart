import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:tuple/tuple.dart';

class RulesChangeEstatus {

  SnackbarUI snackbarUI = SnackbarUI();

  Tuple2<bool, int> canChangeEstatusStart(int idEstatus) {
    if(idEstatus == 7){
      return const Tuple2(true, 19);
    }
    snackbarUI.snackbarInfo('El contrato aun no se ha aceptado', 'No puedes iniciar el contrato hasta aceptar el contrato');
    return const Tuple2(false, 0);
  }

  Tuple2<bool, int> canChangeEstatusAccept(int idEstatus) {
    if(idEstatus == 18 || idEstatus == 29){
      return const Tuple2(true, 7);
    }
    snackbarUI.snackbarInfo('Ya has aceptado el contrato', 'No puedes aceptar el contrato más de una vez');
    return const Tuple2(false, 0);
  }

  Tuple2<bool, int> canChangeEstatusReject(int idEstatus) {
    if(idEstatus == 7){
      return const Tuple2(true, 8);
    }
    snackbarUI.snackbarInfo('El contrato no se encuentra en espera', 'No puedes rechazar el contrato');
    return const Tuple2(false, 0);
  }


  //** */ RULES FOR TASKS IN CONTRACT

  Tuple2<bool, int> canChangeEstatusTaskStart(int idEstatus) {
    if(idEstatus == 18 || idEstatus == 29){
      return const Tuple2(true, 7);
    }
    if(idEstatus == 8){
      snackbarUI.snackbarInfo('Tarea Cancelada', 'No puedes iniciar una tarea cancelada');
    }
    if(idEstatus == 19){
      snackbarUI.snackbarInfo('Tarea en curso', 'No puedes iniciar una tarea en curso');
    }
    if(idEstatus == 9){
      snackbarUI.snackbarInfo('Tarea Finalizada', 'No puedes iniciar una tarea finalizada');
    }
    return const Tuple2(false, 0);
  }

  Tuple2<bool, int> canChangeFinishTask(int idEstatus) {
    if(idEstatus == 26 || idEstatus == 19){
      return const Tuple2(true, 9);
    }
    if(idEstatus == 8){
      snackbarUI.snackbarInfo('Tarea Rechazada', 'No puedes finalizar una tarea rechazada');
    }
    if(idEstatus == 18 || idEstatus == 7){
      snackbarUI.snackbarInfo('Tarea no iniciada', 'No puedes finalizar una tarea no iniciada');
    }
    if(idEstatus == 9){
      snackbarUI.snackbarInfo('Tarea Finalizada', 'No puedes finalizar una tarea finalizada');
    }
    return const Tuple2(false, 0);
  }

  Tuple2<bool, int> canChangePostponeTask(int idEstatus) {
    if(idEstatus == 19 || idEstatus == 7){
      return const Tuple2(true, 26);
    }
    if(idEstatus == 8){
      snackbarUI.snackbarInfo('Tarea Cancelada', 'No puedes posponer una tarea cancelada');
    }
    if(idEstatus == 26){
      snackbarUI.snackbarInfo('Tarea Pospuesta', 'No puedes posponer una tarea ya pospuesta');
    }
    if(idEstatus == 9){
      snackbarUI.snackbarInfo('Tarea Finalizada', 'No puedes posponer una tarea finalizada');
    }
    return const Tuple2(false, 0);
  }

  Tuple2<bool, int> canChangeRejectTask(int idEstatus) {
    if(idEstatus != 9 || idEstatus != 8){
      return const Tuple2(true, 8);
    }
    if(idEstatus == 9){
      snackbarUI.snackbarInfo('Tarea Concluida', 'No puedes rechazar una tarea cancelada');
    }
    if(idEstatus == 26){
      snackbarUI.snackbarInfo('Tarea Pospuesta', 'No puedes rechazar una tarea pospuesta');
    }
    if(idEstatus == 9){
      snackbarUI.snackbarInfo('Tarea Finalizada', 'No puedes rechazar una tarea finalizada');
    }
    return const Tuple2(false, 0);
  }


}
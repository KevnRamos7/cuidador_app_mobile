import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Domain/Model/Catalogos/metodo_pago_usuario.dart';
import '../../../Domain/Utilities/connection_string.dart';

class FinanzasRequest extends GetConnect{

  dynamic usuario = GetStorage().read('usuario');
  SnackbarUI snackbar = SnackbarUI();

  Future<bool> addCreditCard(MetodoPagoUsuario tarjeta) async{
    String vencimiento = convertToDate(tarjeta.fechaVencimiento!);
    String numero = tarjeta.numeroTarjeta!.replaceAll(' ', '');
    int usuarioId = usuario['idUsuario'].toInt();
    try{
      Response response = await post('${ConnectionString.connectionString}Finanzas/añadirTarjeta',
      {
        'numeroTarjeta': numero,
        'fechaVencimiento': vencimiento,
        'cvv' : tarjeta.cvv,
        'nombreTitular' : tarjeta.nombreBeneficiario,
        'usuarioId' : usuarioId
      });
      
      switch(response.statusCode){
        case 200:
          return true;
        case 400:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al añadir la tarjeta');
        case 500:
          snackbar.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return Future.error('Error al añadir la tarjeta');
        default:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
      }

    }
    catch(e){
      snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      return false;
    }
  }

  Future<bool> recargarSaldo(int idMetodoPago, double importe) async{
    int usuarioId = usuario['idUsuario'].toInt();
    try{
      Response response = await post('${ConnectionString.connectionString}Finanzas/recargarSaldo',
      {
        'idUsuario': usuarioId,
        'idMetodoPago': idMetodoPago,
        'importe' : importe
      });
      

      switch(response.statusCode){
        case 200:
          return true;
        case 400:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al recargar el saldo');
        case 500:
          snackbar.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return Future.error('Error al recargar el saldo');
        default:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
      }
    }
    catch(e){
      snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      return false;
    }
  }

  Future<bool> retirarSaldo(int idCuentaBancaria, double importe, int idSaldo) async{
    int usuarioId = usuario['idUsuario'].toInt();
    try{
      Response response = await post('${ConnectionString.connectionString}Finanzas/retirarSaldo',
      {
        'idCuentaBancaria': idCuentaBancaria,
        'importe' : importe,
        'idSaldo' : idSaldo,
        'usuarioId': usuarioId
      });
      
      switch(response.statusCode){
        case 200:
          return true;
        case 400:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al retirar el saldo');
        case 500:
          snackbar.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return Future.error('Error al retirar el saldo');
        default:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
      }
    }
    catch(e){
      snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      return false;
    }
  }

  Future<bool> modificarCuentaBancaria(int idCuentaBancaria, String numeroCuenta, double clabe, String banco) async{
    try{
      Response response = await post('${ConnectionString.connectionString}Finanzas/modificarCuentaBancaria',
      {
        'idCuentaBancaria': idCuentaBancaria,
        'numeroCuenta' : numeroCuenta,
        'clabeInterbancaria' : clabe,
        'nombreBanco' : banco
      });
      
      switch(response.statusCode){
        case 200:
          return true;
        case 400:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return Future.error('Error al modificar la cuenta bancaria');
        case 500:
          snackbar.snackbarError('Error Interno del Servidor.', 'Intenta más tarde');
          return Future.error('Error al modificar la cuenta bancaria');
        default:
          snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
          return false;
      }

    }
    catch(e){
      snackbar.snackbarError('Solicitud no procesada correctamente.', 'Intenta más tarde');
      return false;
    }
  }

  String convertToDate(String fecha){
    List<String> fechaSplit = fecha.split('/');
    String fechaNueva = '20${fechaSplit[1]}-${fechaSplit[0]}-01';
    return fechaNueva;
  }

}
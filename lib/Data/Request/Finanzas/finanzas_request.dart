import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Domain/Model/Catalogos/metodo_pago_usuario.dart';
import '../../../Domain/Utilities/connection_string.dart';

class FinanzasRequest extends GetConnect{

  dynamic usuario = GetStorage().read('usuario');

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
      if(response.status.hasError){
        return Future.error('Error al agregar la tarjeta de credito');
      }
      return true;
    }
    catch(e){
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
      if(response.status.hasError){
        return Future.error('Error al recargar el saldo');
      }
      return true;
    }
    catch(e){
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
      if(response.status.hasError){
        return Future.error('Error al retirar el saldo');
      }
      return true;
    }
    catch(e){
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
      if(response.status.hasError){
        return Future.error('Error al modificar la cuenta bancaria');
      }
      return true;
    }
    catch(e){
      return false;
    }
  }

  String convertToDate(String fecha){
    List<String> fechaSplit = fecha.split('/');
    String fechaNueva = '20${fechaSplit[1]}-${fechaSplit[0]}-01';
    return fechaNueva;
  }

}
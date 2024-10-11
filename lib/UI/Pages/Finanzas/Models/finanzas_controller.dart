import 'package:cuidador_app_mobile/Data/Request/Finanzas/finanzas_request.dart';
import 'package:cuidador_app_mobile/Data/Response/Finanzas/finanzas_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/finanzas_cliente.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/finanzas_cuidador.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../Domain/Model/Catalogos/cuenta_bancaria.dart';
import '../../../../Domain/Model/Catalogos/metodo_pago_usuario.dart';

class FinanzasController extends GetxController{

  FinanzasResponse finanzasResponse = FinanzasResponse();
  FinanzasRequest finanzasRequest = FinanzasRequest();

  RxList<MetodoPagoUsuario> creditCardsList = <MetodoPagoUsuario>[].obs;
  Rx<CuentaBancaria> bankAccount = CuentaBancaria().obs;
  SnackbarUI snackbarUI = SnackbarUI();

  Rx<FinanzasCliente> finanzasCliente = FinanzasCliente().obs;
  Rx<FinanzasCuidador> finanzasCuidador = FinanzasCuidador().obs;

  RxString nombreBeneficiario = ''.obs;
  RxString numeroTarjeta = ''.obs;
  RxString fechaVencimiento = ''.obs;
  RxString cvv = ''.obs;

  RxBool loadingAddCard = false.obs;
  RxBool loadingAddBankAccount = false.obs;
  RxBool loadingDisposeCash = false.obs;
  RxBool loadingModifyAccount = false.obs;
  RxBool loadingScreen = false.obs;

  @override
  void onInit() async{
    super.onInit();
    loadingScreen.value = true;
    try{
      dynamic usuario = GetStorage().read('usuario');
      if(usuario['tipoUsuarioid'] == 2){ 
        await cargarFinanzasCliente();
      }
      else{
        await cargarFinanzasCuidador();
      }
      loadingScreen.value = false;
    }catch(e){
      loadingScreen.value = false;
      snackbarUI.snackbarError('Error al cargar las finanzas', e.toString());
    }
  }

  Future<void> cargarFinanzasCliente() async{
    dynamic usuario = GetStorage().read('usuario');
    try{
      finanzasCliente.value = await finanzasResponse.getFinanzasCliente(usuario['idUsuario']);
      finanzasCliente.refresh();
      creditCardsList.assignAll(finanzasCliente.value.metodoPagoUsuario!);
    }
    catch(e){
      snackbarUI.snackbarError('Error al cargar las finanzas', e.toString());
    }
  }

  Future<void> cargarFinanzasCuidador() async{
    try{
      finanzasCuidador.value = await finanzasResponse.getFinanzasCuidador();
      finanzasCuidador.refresh();
      bankAccount.value = finanzasCuidador.value.cuentaBancaria!;
    }
    catch(e){
      snackbarUI.snackbarError('Error al cargar las finanzas', e.toString());
    }
  }

  Future<void> modificarCuentaBancaria(double clabe, dynamic banco) async{
    loadingModifyAccount.value = true;
    try{
      bool response = await finanzasRequest.modificarCuentaBancaria(
        bankAccount.value.idCuentaBancaria!, 
        bankAccount.value.numeroCuenta.toString(), 
        clabe, 
        banco
      );
      if(response){
        Get.back();
        await cargarFinanzasCuidador();
        snackbarUI.snackbarSuccess('Cuenta Bancaria Modificada!', 'Se ha modificado la cuenta bancaria');
      }
      else{
        snackbarUI.snackbarError('Error al modificar la cuenta bancaria', 'Ha ocurrido un error al modificar la cuenta bancaria');
      }
    }
    catch(e){
      snackbarUI.snackbarError('Error al modificar la cuenta bancaria', e.toString());
      loadingModifyAccount.value = false;
    }
    loadingModifyAccount.value = false;
  }

  Future<void> retirarSaldo(double monto) async{
    loadingDisposeCash.value = true;
    try{
      bool response = await finanzasRequest.retirarSaldo(bankAccount.value.idCuentaBancaria!, monto, finanzasCuidador.value.saldoId!);
      if(response){
        Get.back();
        await cargarFinanzasCuidador();
        snackbarUI.snackbarSuccess('Retiro Exitoso!', 'Se ha retirado el saldo de tu cuenta bancaria');
      }
      else{
        snackbarUI.snackbarError('Error al retirar el saldo', 'Ha ocurrido un error al retirar el saldo de tu cuenta bancaria');
      }
    }
    catch(e){
      snackbarUI.snackbarError('Error al retirar el saldo', e.toString());
      loadingDisposeCash.value = false;
    }
    loadingDisposeCash.value = false;
  }

  Future<void> addTarjeta(MetodoPagoUsuario tarjeta) async{
    loadingAddCard.value = true;
    try{
      bool response = await finanzasRequest.addCreditCard(tarjeta);
      if(response){
        await cargarFinanzasCliente();
        snackbarUI.snackbarSuccess('Tarjeta Agregada!', 'Se ha agregado la tarjeta de credito');
        Get.toNamed('/finanzas');
      }
      else{
        snackbarUI.snackbarError('Error al agregar la tarjeta', 'Ha ocurrido un error al agregar la tarjeta de credito');
      }
    }
    catch(e){
      snackbarUI.snackbarError('Error al agregar la tarjeta', e.toString());
      loadingAddCard.value = false;
    }
    loadingAddCard.value = false;
  }

  Future<void> recargarSaldo(MetodoPagoUsuario card, dynamic cantidad, String cvv) async{
    
    if(cantidad ==  null || cvv.isEmpty){
      snackbarUI.snackbarError('Campos Incompletos!', 'Ingresa un monto y el CVV de la tarjeta');
      return;
    }
    double? monto = double.tryParse(cantidad);
    if(monto! < 0){
      snackbarUI.snackbarError('Monto Invalido!', 'Ingresa un monto valido');
      return;
    }

    loadingAddBankAccount.value = true;
    bool response = await finanzasRequest.recargarSaldo(card.idMetodoPagoUsuario!, monto);
    if(!response){
      snackbarUI.snackbarError('Error al recargar!', 'Ha ocurrido un error al recargar el saldo');
      loadingAddBankAccount.value = false;
      return;
    }

    await cargarFinanzasCliente();
    loadingAddBankAccount.value = false;
    Get.back();
    snackbarUI.snackbarSuccess('Recarga Exitosa!', 'Se ha recargado \$${monto.toStringAsFixed(2)} a tu saldo');
  }

}
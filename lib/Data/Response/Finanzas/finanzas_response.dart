
import 'package:cuidador_app_mobile/Domain/Model/Objects/finanzas_cliente.dart';
import 'package:cuidador_app_mobile/Domain/Model/Objects/finanzas_cuidador.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Domain/Model/Catalogos/salario_cuidador.dart';

class FinanzasResponse extends GetConnect{

  Future<FinanzasCliente> getFinanzasCliente(int idUsuario) async{
      FinanzasCliente finanzasCliente = FinanzasCliente();
      try{
        Response response = await get('${ConnectionString.connectionString}Finanzas/finanzasUsuarioCliente/$idUsuario');
        
        if(response.status.hasError){
          return Future.error('Error al obtener la lista de finanzas');
        }
        else{ 
          finanzasCliente = FinanzasCliente.fromJson(response.body);
        }
        return finanzasCliente;
      }
      catch(e){
        return finanzasCliente;
      }
  }

  Future<FinanzasCuidador> getFinanzasCuidador() async{
      dynamic usuario = GetStorage().read('usuario');
      FinanzasCuidador finanzasCliente = FinanzasCuidador();
      try{
        Response response = await get('${ConnectionString.connectionString}Finanzas/finanzasUsuarioCuidador/${usuario['idUsuario']}');

        if(response.status.hasError){
          return Future.error('Error al obtener la lista de finanzas');
        }
        else{
          finanzasCliente = FinanzasCuidador.fromJson(response.body);
        }
        return finanzasCliente;
      }
      catch(e){
        return finanzasCliente;
      }
  }

  Future<SalarioCuidador> getSalarioCuidador(int idUsuario) async{
      dynamic usuario = GetStorage().read('usuario');
      SalarioCuidador salarioCuidador = SalarioCuidador();
      try{
        Response response = await get('${ConnectionString.connectionString}Finanzas/salarioCuidador/$idUsuario}');

        if(response.status.hasError){
          return Future.error('Error al obtener el salario');
        }
        else{
          salarioCuidador = SalarioCuidador.fromJson(response.body);
        }
        return salarioCuidador;
      }
      catch(e){
        return salarioCuidador;
      }
  }

}
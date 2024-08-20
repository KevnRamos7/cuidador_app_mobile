import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:get/get.dart';

class ProfileResponse extends GetConnect{

  Future<UsuarioModel> getProfileCuidador(int id) async{
    // final response = await get('https://mocki.io/v1/646ec151-81fe-4403-891f-d326b8180e2b');
    final response = await get('${ConnectionString.connectionString}Usuario/verUsuarioWeb/$id');
    if(response.statusCode == 200){
      return UsuarioModel.fromJson(response.body);
    }else{
      throw Exception('Error al cargar el perfil del cuidador');
    }
  }

}
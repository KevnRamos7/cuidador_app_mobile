import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:get/get.dart';

class ProfileResponse extends GetConnect{

  Future<UsuarioModel> getProfileCuidador() async{
    final response = await get('https://mocki.io/v1/5fde962e-5626-416b-9ef8-f80ab54ad4b0');
    if(response.statusCode == 200){
      return UsuarioModel.fromJson(response.body);
    }else{
      throw Exception('Error al cargar el perfil del cuidador');
    }
  }

}
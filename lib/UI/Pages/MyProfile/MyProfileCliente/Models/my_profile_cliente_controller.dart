import 'dart:io';

import 'package:cuidador_app_mobile/Data/Request/MyProfile/my_profile_request.dart';
import 'package:cuidador_app_mobile/Data/Response/MyProfile/my_profile_response.dart';
import 'package:cuidador_app_mobile/Domain/Model/Catalogos/padecimientos_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../Domain/Model/Perfiles/datos_medicos_model.dart';
import '../../../../../Domain/Model/Perfiles/domicilio_model.dart';

class MyProfileClienteController extends GetxController{

  MyProfileResponse myProfileResponse = MyProfileResponse();
  MyProfileRequest myProfileRequest = MyProfileRequest();

  RxInt currentIndex = 0.obs;
  RxBool inicioRapido = false.obs;

  RxBool loading = false.obs;
  RxBool savingModifyData = false.obs;
  Rx<File> pickedImage = File('').obs;

  Rx<UsuarioModel> currentUser = UsuarioModel().obs; 

  @override
  void onInit() async {
    super.onInit();
    await getMyProfile();
  }

  Future<void> uploadImage() async {
    loading.value = true;
    if(pickedImage.value.path.isNotEmpty){
      try
      {
        String fileName = currentUser.value.persona!.first.nombre! + currentUser.value.persona!.first.apellidoPaterno! + currentUser.value.persona!.first.apellidoMaterno!;
        await myProfileRequest.uploadImage(fileName, pickedImage.value);
        await getMyProfile();
        loading.value = false;
      }
      catch(e){
        loading.value = false;
      }
    }
  }

  Future<void> getMyProfile() async {
    loading.value = true;
    try
    {
      dynamic persona = GetStorage().read('perfil');
      currentUser.value = await myProfileResponse.getMyProfile(persona['idPersona']);
      currentUser.refresh();
      loading.value = false;
    }
    catch(e){
      loading.value = false;
    }
  }

  Future<void> getDomicilio() async {
    loading.value = true;
    try
    {
      dynamic persona = GetStorage().read('perfil');
      currentUser.value.persona!.first.domicilio = await myProfileResponse.getDomicilio(persona['idPersona']);
      loading.value = false;
    }
    catch(e){
      loading.value = false;
    }
  }

  Future<void> getDatosMedicos() async {
    loading.value = true;
    try
    {
      dynamic persona = GetStorage().read('perfil');
      currentUser.value.persona!.first.datosMedicos = await myProfileResponse.getDatosMedicos(persona['idPersona']);
      loading.value = false;
    }
    catch(e){
      loading.value = false;
    }
  }

  Future<void> getPadecimientos() async {
    loading.value = true;
    try
    {
      dynamic persona = GetStorage().read('perfil');
      currentUser.value.persona?.first.datosMedicos ??= DatosMedicosModel();
      currentUser.value.persona?.first.datosMedicos?.padecimientos = await myProfileResponse.getPadecimientos(persona['idPersona']);
      loading.value = false;
    }
    catch(e){
      loading.value = false;
    }
  }


  Future<bool> updateProfile() async {
    savingModifyData.value = true;
    PersonaModel updateProfile = currentUser.value.persona!.first;
    try
    {
      bool response = await myProfileRequest.updateProfile(updateProfile);
      savingModifyData.value = false;
      if(response){
        getMyProfile();
      }
      return response;
    }
    catch(e){
      savingModifyData.value = false;
      return false;
    }
  }

  Future<bool> updateDomicilio() async {
    DomicilioModel updateDomicilio = currentUser.value.persona!.first.domicilio!;
    savingModifyData.value = true;
    try
    {
      bool response = await myProfileRequest.updateDomicilio(updateDomicilio);
      savingModifyData.value = false;
      return response;
    }
    catch(e){
      savingModifyData.value = false;
      return false;
    }
  }

  Future<bool> updateDatosMedicos() async {
    DatosMedicosModel updateDatosMedicos = currentUser.value.persona!.first.datosMedicos!;
    savingModifyData.value = true;
    try
    {
      bool response = await myProfileRequest.updateDatosMedicos(updateDatosMedicos);
      savingModifyData.value = false;
      return response;
    }
    catch(e){
      savingModifyData.value = false;
      return false;
    }
  }

  Future<bool> updatePadecimientos() async {
    List<PadecimientosModel> padecimientos = currentUser.value.persona!.first.datosMedicos!.padecimientos!;
    savingModifyData.value = true;
    try
    {
      bool response = await myProfileRequest.updatePadecimientos(padecimientos);
      savingModifyData.value = false;
      return response;
    }
    catch(e){
      savingModifyData.value = false;
      return false;
    }
  }

  Future<bool> deletePadecimiento(int idPadecimiento) async {
    savingModifyData.value = true;
    try
    {
      bool response = await myProfileRequest.deletePadecimiento(idPadecimiento);
      if(response){
        getPadecimientos();
        currentUser.refresh();
      }
      savingModifyData.value = false;
      return response;
    }
    catch(e){
      savingModifyData.value = false;
      return false;
    }
  } 
  
  Future<bool> addPadecimiento(PadecimientosModel padecimiento) async {
    savingModifyData.value = true;
    try
    {
      Get.back();
      dynamic persona = GetStorage().read('perfil');
      bool response = await myProfileRequest.addPadecimiento(padecimiento, persona['idPersona']);
      if(response){
        getPadecimientos();
        currentUser.refresh();
      }
      savingModifyData.value = false;
      return response;
    }
    catch(e){
      savingModifyData.value = false;
      return false;
    }
  }

  Future<bool> updatePassword(String password) async {
    savingModifyData.value = true;
    try
    {
      dynamic usuario = GetStorage().read('usuario');
      bool response = await myProfileRequest.updatePassword(usuario['idUsuario'], password);
      if(response){
        currentUser.value.contrasena = password;
      }
      savingModifyData.value = false;
      return response;
    }
    catch(e){
      savingModifyData.value = false;
      return false;
    }
  }

  void changeIndex(int index){
    currentIndex.value = index;
  }

  Future<void> modifyPersonalData(PersonaModel persona) async {
    savingModifyData.value = true;
    try
    {
      // await myProfileResponse.modifyPersonalData(currentUser.value.persona?.first);
      savingModifyData.value = false;
    }
    catch(e){
      savingModifyData.value = false;
    }
  }

}
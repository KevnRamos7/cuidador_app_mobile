import 'dart:io';

import 'package:cuidador_app_mobile/Domain/Model/Perfiles/datos_medicos_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/domicilio_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Domain/Model/Catalogos/padecimientos_model.dart';
import '../../../Domain/Utilities/connection_string.dart';

class MyProfileRequest extends GetConnect{

  SnackbarUI snackbarUI = SnackbarUI();

  Future<bool> uploadImage(String imageName, File image) async {
    try
    {
      final storageRef = FirebaseStorage.instance.ref().child('$imageName/${DateTime.now().millisecondsSinceEpoch}.png');

      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      if(downloadUrl.isEmpty){
        snackbarUI.snackbarError('Error', 'Error al subir la imagen');
        return false;
      }

      final response = await post('${ConnectionString.connectionString}MyProfile/updateAvatar',
      {
        'idPersona' : GetStorage().read('perfil')['idPersona'],
        'avatarImage' : downloadUrl,
      });

      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Imagen actualizada correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al actualizar la imagen');
          return false;
      }
    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }
  }

  Future<bool> updateProfile(PersonaModel updateProfile) async {
    try
    {
      final response = await post('${ConnectionString.connectionString}MyProfile/updateProfile',
      {
        'idPersona' : updateProfile.idPersona ?? 0,
        'correoElectronico' : updateProfile.correoElectronico ?? '',
        'telefonoParticular' : updateProfile.telefonoParticular ?? '',
        'telefonoMovil' : updateProfile.telefonoMovil ?? '',
        'telefonoEmergencia' : updateProfile.telefonoEmergencia ?? '',
        'nombreCompletoFamiliar' : updateProfile.nombreCompletoFamiliar ?? '',
      });

      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Perfil actualizado correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al actualizar el perfil');
          return false;
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }

  }

  Future<bool> updateDomicilio(DomicilioModel updateDomicilio) async {
    try
    {
      final response = await post('${ConnectionString.connectionString}MyProfile/updateDomicilio',
      {
        'idDomicilio' : updateDomicilio.idDomicilio,
        'calle' : updateDomicilio.calle,
        'colonia' : updateDomicilio.colonia,
        'numeroExterior' : updateDomicilio.numeroExterior,
        'numeroInterior' : updateDomicilio.numeroInterior,
        'ciudad' : updateDomicilio.ciudad,
        'estado' : updateDomicilio.estado,
        'pais' : updateDomicilio.pais,
        'referencias' : updateDomicilio.referencias,
      });
      
      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Domicilio actualizado correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al actualizar el domicilio');
          return false;
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }
  }

  Future<bool> updateDatosMedicos(DatosMedicosModel updateDatosMedicos) async {
    try
    {
      final response = await post('${ConnectionString.connectionString}MyProfile/updateDatosMedicos',
      {
        'idDatosMedicos' : updateDatosMedicos.idDatosMedicos,
        'nombreMedicoFamiliar' : updateDatosMedicos.nombreMedicoFamiliar,
        'telefonoMedicoFamiliar' : updateDatosMedicos.telefonoMedicoFamiliar,
        'antecedentesMedicos' : updateDatosMedicos.antecedentesMedicos,
        'alergias' : updateDatosMedicos.alergias,
      });
      
      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Datos médicos actualizados correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al actualizar los datos médicos');
          return false;
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }
  }

  Future<bool> updatePadecimientos(List<PadecimientosModel> updatePadecimientos) async {
    try
    {

      List<Map<String, dynamic>> padecimientosJson = updatePadecimientos.map((padecimiento) => {
        'idPadecimiento': padecimiento.idPadecimiento,
        'nombrePadecimiento': padecimiento.nombre,
        'padeceDesde': padecimiento.padeceDesde,
      }).toList();

      final response = await post('${ConnectionString.connectionString}MyProfile/updatePadecimiento', padecimientosJson);
      
      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Padecimientos actualizados correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al actualizar los padecimientos');
          return false;
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }
  }

  Future<bool> deletePadecimiento(int idPadecimiento) async {
    try
    {
      final response = await delete('${ConnectionString.connectionString}MyProfile/deletePadecimiento/$idPadecimiento');
      
      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Padecimiento eliminado correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al eliminar el padecimiento');
          return false;
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }
  }

  Future<bool> addPadecimiento(PadecimientosModel padecimiento, int idPersona) async {
    try
    {
      final response = await post('${ConnectionString.connectionString}MyProfile/addPadecimiento',
      {
        'idPersona' : idPersona,
        'nombrePadecimiento': padecimiento.nombre,
        'padeceDesde': padecimiento.padeceDesde,
      });
      
      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Padecimiento agregado correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al agregar el padecimiento');
          return false;
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }
  }

  Future<bool> updatePassword(int idUsuario, String password) async {
    try
    {
      final response = await post('${ConnectionString.connectionString}MyProfile/updatePassword',
      {
        'idUsuario' : idUsuario,
        'password' : password,
      });
      
      switch(response.statusCode){
        case 200:
          snackbarUI.snackbarSuccess('Éxito', 'Contraseña actualizada correctamente');
          return true;
        default:
          snackbarUI.snackbarError('Error', 'Error al actualizar la contraseña');
          return false;
      }

    }
    catch(e){
      snackbarUI.snackbarError('Ha ocurrido un error dentro de la aplicación', e.toString());
      return false;
    }
  }

}
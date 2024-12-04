import 'package:cuidador_app_mobile/Domain/Model/Perfiles/datos_medicos_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/items_profile.dart';

class DMedicosCliente{

  ItemsProfile itemsProfile = Get.put(ItemsProfile());

  Widget contenido(){
    return Expanded(
      child: Stack(
        children: [
          GetBuilder<MyProfileClienteController>(
            id: 'datosMedicos',
            builder: (_) {
              return ListView(
                children: [
                  itemsProfile.header(title: 'Datos Médicos'),
                  itemsProfile.item(title: 'Tipo de Sangre', value: _.currentUser.value.persona?.first.datosMedicos?.tipoSanguineo ?? '', isEditable: false),
                  itemsProfile.item(title: 'Médico Familiar', value: _.currentUser.value.persona?.first.datosMedicos?.nombreMedicoFamiliar ?? '', isEditable: true, onChanged: (value) => {
                    _.currentUser.value.persona?.first.datosMedicos?.nombreMedicoFamiliar = value,
                    _.currentUser.update((user) {
                      user?.persona?.first.datosMedicos?.nombreMedicoFamiliar = value;
                    }),
                    _.update(['datosMedicos'])
                  }),
                  itemsProfile.item(title: 'Teléfono Médico Familiar', value: _.currentUser.value.persona?.first.datosMedicos?.telefonoMedicoFamiliar ?? '', isEditable: true, onChanged: (value) => {
                    _.currentUser.value.persona?.first.datosMedicos?.telefonoMedicoFamiliar = value,
                    _.currentUser.update((user) {
                      user?.persona?.first.datosMedicos?.telefonoMedicoFamiliar = value;
                    }),
                    _.update(['datosMedicos'])
                  }),
                  itemExpanded(title: 'Antecedentes',listado: (_.currentUser.value.persona?.first.datosMedicos?.antecedentesMedicos ?? '').split(',').toList(), onSave: (p0) => {
                    _.currentUser.value.persona?.first.datosMedicos?.antecedentesMedicos = p0.toList().join(','),
                    _.update(['datosMedicos'])
                  },icono: const Icon(CupertinoIcons.heart_fill, color: Colors.red)),
                  itemExpanded(title: 'Alergias',listado: (_.currentUser.value.persona?.first.datosMedicos?.alergias ?? '').split(',').toList(), onSave: (p0) => {
                    _.currentUser.value.persona?.first.datosMedicos?.alergias = p0.toList().join(','),
                    _.update(['datosMedicos'])
                  }, icono: const Icon(CupertinoIcons.capsule_fill, color: Colors.blue)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemExpanded({
  required String title,
  required List<String> listado,
  Function(List<String>)? onSave,
  required Widget icono
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: ExpansionTile(
      title: Text(title, style: TextStyle(color: Colors.grey[600])),
      leading: icono,
      children: [
        ...listado.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                labelText: value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                suffixIcon: const Icon(
                  CupertinoIcons.pencil_circle_fill,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
              onChanged: (newValue) {
                listado[index] = newValue; // Usa el índice directamente
                if (onSave != null) {
                  onSave(listado);
                }
              },
            ),
          );
        }),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            listado.add('');
            if (onSave != null) {
              onSave(listado);
            }
          },
          child: const Text(
            'Agregar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

}
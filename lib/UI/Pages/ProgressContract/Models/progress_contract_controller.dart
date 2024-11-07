import 'package:cuidador_app_mobile/Domain/Model/Catalogos/estatus_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/tareas_contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/domicilio_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:get/get.dart';

import '../../../../Domain/Model/Contrato/contrato_model.dart';

class ProgressContractController extends GetxController{

  RxInt currectStep = 0.obs;
  Rx<ContratoModel> contrato = ContratoModel().obs;

  @override
  void onInit() async{
    getContract(32);
    super.onInit();
  }

  Future<void> getContract(int idContrato) async{

    contrato.value = ContratoModel(
      idContrato: 32,
      estatus: EstatusModel(
        idEstatus: 1,
        nombre: "En proceso"
      ),
      personaCliente: PersonaModel(
        idPersona: 1,
        nombre: "Juan",
        apellidoPaterno: "Perez",
        apellidoMaterno: "Gonzalez",
        telefonoMovil: "1234567890",
        correoElectronico: "",
        domicilio: DomicilioModel(
          idDomicilio: 1,
          calle: "Calle 1",
          numeroExterior: "123",
          numeroInterior: "A",
          colonia: "Colonia 1",
          ciudad: "León",
          estado: "Guanajuato",
          pais: "México"
        )
      ),
      personaCuidador: PersonaModel(
        idPersona: 2,
        nombre: "Maria",
        apellidoPaterno: "Gonzalez",
        apellidoMaterno: "Perez",
        telefonoMovil: "0987654321",
        correoElectronico: ""
      ),
      contratoItem: <ContratoItemModel>[
        ContratoItemModel(
          idContratoItem: 1,
          fechaAceptacion: DateTime(2024, 10, 25, 8, 0),
          horarioInicioPropuesto: DateTime(2024, 10, 27, 8, 0),
          horarioFinPropuesto: DateTime(2024, 10, 27, 12, 0),
          importeCuidado: 3000,
          estatus: EstatusModel(
            idEstatus: 1,
            nombre: "En proceso"
          ),
          observaciones: 'Observaciones',
          tareasContrato: <TareasContratoModel>[
            TareasContratoModel(
              idTareasContrato: 1,
              fechaRealizar: DateTime(2024, 10, 27, 8, 0),
              tipoTarea: 'Limpieza',
              tituloTarea: 'Limpieza de la casa',
              descripcionTarea: 'Limpieza de la casa',
            ),
            TareasContratoModel(
              idTareasContrato: 2,
              fechaRealizar: DateTime(2024, 10, 27, 10, 0),
              tipoTarea: 'Cocina',
              tituloTarea: 'Cocinar desayuno',
              descripcionTarea: 'Cocinar desayuno',
            ),
            TareasContratoModel(
              idTareasContrato: 3,
              fechaRealizar: DateTime(2024, 10, 27, 12, 0),
              tipoTarea: 'Cocina',
              tituloTarea: 'Cocinar comida',
              descripcionTarea: 'Cocinar comida',
            ),
          ].obs
        )
      ].obs
    );

  }

}
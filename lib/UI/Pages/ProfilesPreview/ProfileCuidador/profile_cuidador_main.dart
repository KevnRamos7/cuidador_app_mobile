import 'package:cuidador_app_mobile/Domain/Model/Perfiles/comentarios_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProfilesPreview/ProfileCuidador/Models/profile_cuidador_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProfilesPreview/shimmer_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCuidadorMain extends StatelessWidget {

  ProfileCuidadorController con = Get.put(ProfileCuidadorController());
  LetterDates letterDates = LetterDates();
  ShimmerProfile shimmers = Get.put(ShimmerProfile());

  @override
  Widget build(BuildContext context){
    
    return Obx(()=>

      con.isLoading.value == true ? shimmers.shimmerContenedor() :
      Scaffold(
        appBar: AppBar(
          backgroundColor: con.colorBg.value,
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: const Icon(CupertinoIcons.back, color: Colors.white70, size: 25,)),
          centerTitle: true,
          title: Column(
            children: [
              const Text('CUIDADOR', style: TextStyle(color: Colors.white, fontSize: 20),),
              Text('- ${con.profileCuidador.value.nivelUsuario} -', style: const TextStyle(color: Colors.white60, fontSize: 13),),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _summaryProfile(con.colorBg.value),
                      ],
                    ),
                    _listInformation(),
                    _listCardReviews(),
                    _moreInformationComtainer(),
                    _experienceContainer(),
                    _horariosContainer(),
                    const SizedBox(height: 30,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryProfile(Color backgroundColor){
    return SizedBox(
      height: Get.height * 0.4,
      width: Get.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.25,
            child: Stack(
              children: [
                Container(
                  height: Get.height * 0.2,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Get.width * 0.5), 
                      bottomRight: Radius.circular(Get.width * 0.5),
                    ),
                  ),
                ),
                Positioned(
                  bottom: Get.height * -0.01, // Ajusta este valor para posicionar la imagen correctamente
                  left: (Get.width - 150) / 2, // Ajusta este valor para centrar la imagen
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(con.profileCuidador.value.persona?.first.avatarImage ?? '', 
                        width: 150, height: 150, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Image(image: AssetImage('assets/img/shared/avatar_default.jpg'), width: 150, height: 150, fit: BoxFit.cover);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('${con.profileCuidador.value.persona?.first.nombre ?? 'Nombre'} ${con.profileCuidador.value.persona?.first.apellidoMaterno ?? 'Apellido'}', 
            style: const TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\$ ${con.profileCuidador.value.horariosCuidador?.first.precioPorHora ?? 0.0} MXN', style: const TextStyle(color: Color.fromARGB(255, 8, 83, 10), fontSize: 20), textAlign: TextAlign.center,),
              const SizedBox(width: 5,),
              const Text('por hora', style: TextStyle(color: Colors.grey, fontSize: 15), textAlign: TextAlign.center,),
            ],
          ),
          Text('${con.profileCuidador.value.cuidadosRealizados ?? 0} CUIDADOS REALIZADOS', style: const TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.center,),
          SizedBox(
            height: Get.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate((con.profileCuidador.value.comentariosUsuario?.isNotEmpty == true ? (con.profileCuidador.value.comentariosUsuario!.map((c) => c.calificacion!.toDouble()).reduce((a, b) => a + b) / con.profileCuidador.value.comentariosUsuario!.length).toInt() : 0), (index) {
                return const Icon(Icons.star, color: Colors.yellow, size: 20);
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _listInformation(){
    return Container(
      height: Get.height * 0.1,
      width: Get.width * 0.97,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _contentForListInformation(con.profileCuidador.value.cuidadosRealizados.toString(), 'Cuidados'),
          Tooltip(
            message: 'Contratar',
            child: GestureDetector(
              onTap: () {
                Get.offNamed('/contratar', arguments: con.profileCuidador.value);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                width: Get.width * 0.18,
                height: Get.width * 0.18,  // Asegúrate de que la altura sea igual al ancho
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.09)),  // La mitad del ancho/alto para que sea circular
                  color: Colors.blueGrey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(CupertinoIcons.pencil_outline, color: Colors.white, size: 20),
              ),
            ),
          ),
          _contentForListInformation((con.profileCuidador.value.persona?.first.certificaciones?.length ?? 0).toString(), 'Certificaciones'),
        ],
      ),
    );
  }

  Widget _contentForListInformation(String title, String value){
    return SizedBox(
      width: Get.width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.black, fontSize: 20),),
          Text(value, style: const TextStyle(color: Colors.grey, fontSize: 13),),
        ],
      ),
    );
  }

  Widget _listCardReviews(){
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.02),
      height: Get.height * 0.25,
      width: Get.width * 0.97,
      child: Column(
        children: [
          const Text('Reseñas', style: TextStyle(color: Colors.grey, fontSize: 18),),
          Expanded(
            child:  
            con.profileCuidador.value.comentariosUsuario == null ? 
              _notFound('El cuidador aún no cuenta con reseñas')
            :
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: con.profileCuidador.value.comentariosUsuario?.length ?? 0,
              itemBuilder: (context, index){
                ComentariosModel comentario = con.profileCuidador.value.comentariosUsuario![index];
                return _cardReview('${comentario.personaEmisor?.nombre ?? ''} ${comentario.personaEmisor?.apellidoMaterno ?? ''}'
                , letterDates.formatearSoloFecha(comentario.fechaRegistro.toString()), 
                comentario.comentario ?? '', comentario.calificacion ?? 0
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _notFound(String text){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 15),),
      ),
    );
  }

  Widget _cardReview(String name, String date, String review, int stars){
    return Container(
      height: Get.height * 0.3,
      width: Get.width * 0.7,
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: Get.height * 0.02, left: Get.width * 0.02, right: Get.width * 0.02),
            height: Get.height * 0.02,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: const TextStyle(color: Colors.black, fontSize: 15),),
                Row(
                  children: List.generate(stars, (index) {
                    return const Icon(Icons.star, color: Colors.yellow, size: 15);
                  }),
                ),
              ],
            ),
          ),

          Container(
            height: Get.height * 0.025,
            margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.02, right: Get.width * 0.02),
            child: Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13),)
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: Get.height * 0.02, left: Get.width * 0.02, right: Get.width * 0.02),
                child: Text(review, style: const TextStyle(color: Colors.black, fontSize: 15),)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moreInformationComtainer(){
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.02),
      height: Get.height * 0.3,
      width: Get.width * 0.97,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('Más Información', style: TextStyle(color: Colors.grey, fontSize: 18),),
          const SizedBox(height: 20,),
          _profileMoreInformationItem(
            'Miembro Desde:', 
            letterDates.formatearSoloFecha(con.profileCuidador.value.persona?.first.fechaRegistro.toString() ?? DateTime.now().toString()), 
            const Icon(CupertinoIcons.calendar, color: Colors.blueGrey, size: 25)
          ),
          _profileMoreInformationItem(
            'Ubicación', 
            '${con.profileCuidador.value.persona?.first.domicilio?.ciudad}, ${con.profileCuidador.value.persona?.first.domicilio?.estado}, ${con.profileCuidador.value.persona?.first.domicilio?.pais}',
            const Icon(CupertinoIcons.calendar, color: Colors.blueGrey, size: 25)
          ),
           _profileMoreInformationItem(
            'Edad', 
            con.profileCuidador.value.persona?.first.fechaNacimiento != null ? letterDates.calcularEdad(con.profileCuidador.value.persona?.first.fechaNacimiento ??  DateTime.now().toString()) : '0', 
            const Icon(CupertinoIcons.calendar, color: Colors.blueGrey, size: 25)
          ),
           _profileMoreInformationItem(
            'Género', 
            con.profileCuidador.value.persona?.first.genero ?? 'No especificado', 
            const Icon(CupertinoIcons.calendar, color: Colors.blueGrey, size: 25)
          ),
        ],
      ),
    );
  }

  Widget _experienceContainer(){
    LetterDates letterDates = LetterDates();
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.02),
      height: Get.height * 0.3,
      width: Get.width * 0.97,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('Experiencia', style: TextStyle(color: Colors.grey, fontSize: 18),),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: con.profileCuidador.value.persona?.first.certificaciones?.length ?? 0,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(con.profileCuidador.value.persona?.first.certificaciones?[index].descripcion ?? '', style: const TextStyle(color: Colors.black, fontSize: 15),),
                  subtitle: Text('Experiencia de ${letterDates.calcularEdad(con.profileCuidador.value.persona?.first.certificaciones?[index].fechaCerficacion ?? '')} años', style: const TextStyle(color: Colors.grey, fontSize: 13),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _horariosContainer(){
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.02),
      height: Get.height * 0.3,
      width: Get.width * 0.97,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('Experiencia', style: TextStyle(color: Colors.grey, fontSize: 18),),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: con.profileCuidador.value.persona?.first.certificaciones?.length ?? 0,
              itemBuilder: (context, index){
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(con.profileCuidador.value.horariosCuidador![index].diaSemana ?? '', style: const TextStyle(color: Colors.black, fontSize: 15),),
                      Text('${con.profileCuidador.value.horariosCuidador![index].horaInicio}   a   ${con.profileCuidador.value.horariosCuidador![index].horaFin}', style: const TextStyle(color: Colors.black, fontSize: 15),),
                    ],
                  ),
                  subtitle: Text('Costo por hora de \$${con.profileCuidador.value.horariosCuidador?[index].precioPorHora ?? 0}', style: const TextStyle(color: Colors.grey, fontSize: 13),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileMoreInformationItem(String title, String value, Icon? icon){  
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.01),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.white, width: 1))
      ),
      padding: EdgeInsets.only(bottom: Get.height * 0.01, top: Get.height * 0.01, left: Get.width * 0.05, right: Get.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis,)),
          Text(value, style: const TextStyle(color: Colors.black, fontSize: 13), textAlign: TextAlign.start),
        ],
      ),
    );
  }

}
// import 'package:flutter/cupertino.dart';
// import 'package:shadcn_ui/shadcn_ui.dart';

// class DialogsUI extends StatelessWidget {

//   const DialogsUI(DialogsParams params, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return _dialogUI(context, params);
//   }

//   Future<void> _dialogUI(BuildContext context, DialogsParams params) {
//     return showShadDialog(
//       context: context, 
//       builder: (context) => ShadDialog(
//         title: Text(params.titulo),
//         description: Text(params.mensaje),
//         content: params.contenido,
//       ) 
//     );
//   }

// }

// class DialogsParams {
//   final String titulo;
//   final String mensaje;
//   final String textoBoton;
//   final Widget contenido;

//   DialogsParams({
//     required this.titulo,
//     required this.mensaje,
//     required this.textoBoton,
//     required this.contenido
//   });
// }
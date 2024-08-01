// import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PullDownMenu extends StatelessWidget {
  final int index;

  PullDownMenu ({required this.index});

  @override
  Widget build(BuildContext context) {
    GlobalKey cardKey = GlobalKey();

    return GestureDetector(
      key: cardKey,
      onTap: () => _showMenu(context),
      child: Card(
        elevation: 2,
        color: const Color.fromARGB(255, 49, 77, 91),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '08:00',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Text(
                'Juan Peréz Robledo',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.green[100],
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy - size.height,
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  color: Colors.blueGrey,
                  child: const Icon(
                    CupertinoIcons.clock_fill,
                    color: Colors.white,
                  ),
                ),
                title: const Text('¿Qué deseas hacer?'),
                subtitle: const Text('Selecciona una opción'),
                onTap: () {},
              ),
              const Divider(),
              const ListTile(
                title: Text('Acciones'),
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.pencil_circle),
                title: const Text('Titulo'),
                onTap: () {
                  Get.back(); // Close the menu
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.pencil_circle),
                title: const Text('Descripción'),
                onTap: () {
                  Get.back(); // Close the menu
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.time),
                title: const Text('Hora'),
                onTap: () {
                  Get.back(); // Close the menu
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.red,
                ),
                title: const Text('Cancelar'),
                onTap: () {
                  Get.back(); // Close the menu
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
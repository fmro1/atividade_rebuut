import 'package:atividade_rebuut/common/custom_drawer_header.dart';
import 'package:atividade_rebuut/common/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 135, 206, 250),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(
                icon: Icons.home,
                text: 'Início',
                page: 0,
              ),
              DrawerTile(
                icon: Icons.list,
                text: 'Categorias',
                page: 1,
              ),
              DrawerTile(
                icon: Icons.list,
                text: 'Produtos',
                page: 2,
              ),
            ],
          ),
        ]
      ),
    );
  }
}

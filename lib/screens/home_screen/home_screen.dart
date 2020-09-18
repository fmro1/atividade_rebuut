import 'package:atividade_rebuut/common/custom_drawer.dart';
import 'package:atividade_rebuut/models/page_manager.dart';
import 'package:atividade_rebuut/screens/categories/components/category_tile.dart';
import 'package:atividade_rebuut/screens/home_screen/components/custom_home_card.dart';
import 'package:atividade_rebuut/screens/products/components/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
      height: 200,
      decoration: BoxDecoration(
        /*borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35)
        ),*/
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF0080FF),
              Color(0xFF7FE5F0)
            ]
        ),
      ),
    );
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          _buildBodyBack(),
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBar(
              title: Text('Atividade Rebuut'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20,),
            CustomHomeCard(
              page: 1,
              title: 'CATEGORIAS',
              bodyText: 'Adicionar e remover',
            ),
            CustomHomeCard(
              page: 2,
              title: 'PRODUTOS',
              bodyText: 'Adicionar e remover',
            ),
          ],
        ),
        ]
      ),
    );
  }
}

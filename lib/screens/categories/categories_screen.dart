import 'package:atividade_rebuut/common/custom_drawer.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/screens/categories/components/category_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.of(context).pushNamed('/add_categoria');
              }
          )
        ],
      ),
      body: Consumer<CategoryManager>(
        builder: (_, categoryManager, __){
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: categoryManager.allCategories.length,
              itemBuilder: (_, index){
                return CategoryListTile(categoryManager.allCategories[index]);
              }
          );
        },
      ),
    );
  }
}

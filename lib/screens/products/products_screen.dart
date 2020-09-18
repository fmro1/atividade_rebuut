import 'package:atividade_rebuut/common/custom_drawer.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:atividade_rebuut/screens/products/components/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.of(context).pushNamed('/add_produto');
              }
          )
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: productManager.allProducts.length,
              itemBuilder: (_, index){
                return ProductListTile(productManager.allProducts[index]);
              }
          );
        },
      ),
    );
  }
}

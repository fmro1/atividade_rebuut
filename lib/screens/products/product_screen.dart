import 'package:atividade_rebuut/common/custom_drawer.dart';
import 'package:atividade_rebuut/models/product.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {

  ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nome),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
      Padding(padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Nome: ${product.nome}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Descrição: ${product.descricao}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Preço: R\$${product.preco?.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Categoria: ${product.categoria}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/editar_produto', arguments: product);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                    ),
                    color: Colors.blue,
                    child: const Text(
                        'Editar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                      ),
                    )
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: FlatButton(
                    onPressed: () async {
                      AlertDialog(
                        title: const Text('Excluir'),
                        content: const Text('Deseja mesmo exluir o produto?'),
                        actions: [
                          FlatButton(
                              onPressed: (){
                                return;
                              },
                              child: Text('NÃO'),
                          ),
                          FlatButton(
                              onPressed: (){
                                product.delete();

                                //avisar ao productmanager que houve mudanca num produto para ele poder refazer a tela
                                context.read<ProductManager>().update(product);

                                Navigator.of(context).pop();
                              },
                              child: Text('SIM'))
                        ],
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    color: Colors.red,
                    child: const Text(
                      'Excluir',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      ),
                    )
                ),
              )
            ],
          ),
        ],
      ),

      )
      ]
    )
    );
  }
}

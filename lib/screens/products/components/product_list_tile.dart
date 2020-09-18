import 'package:atividade_rebuut/models/product.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {

  ProductListTile(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/editar_produto', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome: ${product.nome}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              ),
              Text(
                'Categoria: ${product.categoria}'
              ),
              Text(
                'Descricao: ${product.descricao}'
              ),
              Text(
                'Preco: R\$ ${product.preco?.toStringAsFixed(2)}'
              ),
            ],
          ),
        ),
      ),
    );
  }
}

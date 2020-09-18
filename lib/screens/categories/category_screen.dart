import 'package:atividade_rebuut/common/alert_dialog_widget.dart';
import 'package:atividade_rebuut/models/category.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {

  CategoryScreen(this.category);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.nome}'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome: ${category.nome}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/editar_categoria', arguments: category);
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
                        onPressed: () {
                          VoidCallback continueCallBack = () {
                            //category.delete();

                            context.read<ProductManager>().deletedCat(category);
                            //avisar ao productmanager que houve mudanca num
                            //produto para ele poder refazer a tela
                            context.read<CategoryManager>().delete(category);
                            Navigator.of(context).pop();
                          };
                          showDialog(context: context,
                            builder: (BuildContext context){
                              return CustomAlertDialog('Excluir', 'Deseja realmente excluir a categoria?', continueCallBack);
                            }
                          );
                          /*AlertDialog(
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
                                    category.delete();

                                    //avisar ao productmanager que houve mudanca num produto para ele poder refazer a tela
                                    context.read<CategoryManager>().update(category);

                                    Navigator.of(context).pop();
                                  },
                                  child: Text('SIM'))
                            ],
                          );*/
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
          )
          ),
        ],
      ),
    );
  }
}

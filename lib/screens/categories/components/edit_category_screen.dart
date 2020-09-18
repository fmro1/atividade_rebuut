import 'package:atividade_rebuut/common/alert_dialog_widget.dart';
import 'package:atividade_rebuut/models/category.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatelessWidget {

  EditCategoryScreen(this.category);

  final Category category;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: category,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar ${category.nome}'),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
              children: [
                Padding(padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: category.nome,
                        decoration: const InputDecoration(
                          labelText: 'Nome da categoria',
                          hintText: 'Digite o nome da categoria',
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (name){
                          if(name.length < 3)
                            return 'Nome muito curto (<3)';
                          return null;
                        },
                        onSaved: (name) => category.nome = name,
                      ),
                      SizedBox(height: 20),
                      Consumer<Category>(
                          builder: (_, category, __){
                            return Row(
                              children: [
                                Expanded(
                                  child: FlatButton(
                                      onPressed: () async {
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();

                                          await category.save();

                                          //atualizar a categoria do produto
                                          context.read<ProductManager>().updateCat(category);
                                          //avisar ao categorymanager que houve mudanca num produto para ele poder refazer a tela
                                          context.read<CategoryManager>().update(category);

                                          Navigator.of(context).pop();
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      color: Colors.blue,
                                      child: const Text(
                                        'Salvar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
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
                                ),
                              ],
                            );
                          }
                      ),
                      FlatButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          color: Colors.blue,
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

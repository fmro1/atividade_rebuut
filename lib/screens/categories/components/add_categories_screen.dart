import 'package:atividade_rebuut/common/custom_drawer.dart';
import 'package:atividade_rebuut/models/category.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/page_manager.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:atividade_rebuut/screens/categories/components/category_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoriesScreen extends StatelessWidget {

  AddCategoriesScreen({Category c}){
    c = category;
  }

  Category category = Category();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: category,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Categoria'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome da categoria',
                      hintText: 'Digite o nome da categoria',
                    ),
                    validator: (name){
                      if(name.length < 3)
                        return 'Nome muito curto (<3)';
                      return null;
                    },
                      onSaved: (n) => category.nome = n,
                    ),
                  SizedBox(height: 32,),
                  Consumer<Category>(
                      builder: (_, category, __){
                        return FlatButton(
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();

                                await category.save();

                                //avisar ao productmanager que houve mudanca num produto para ele poder refazer a tela
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
                        );
                      }
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

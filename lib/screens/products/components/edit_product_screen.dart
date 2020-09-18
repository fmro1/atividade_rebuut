import 'package:atividade_rebuut/common/alert_dialog_widget.dart';
import 'package:atividade_rebuut/models/category.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/product.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {

  EditProductScreen(this.product);

  final Product product;

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar ${widget.product.nome}'),
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
                        initialValue: widget.product.nome,
                        decoration: const InputDecoration(
                          labelText: 'Nome do produto',
                          hintText: 'Digite o nome do produto',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        validator: (name){
                          if(name.length < 3)
                            return 'Nome muito curto (<3)';
                          return null;
                        },
                        onSaved: (name) => widget.product.nome = name,
                      ),
                        TextFormField(
                          initialValue: widget.product.descricao,
                          decoration: const InputDecoration(
                            labelText: 'Descrição do produto',
                            hintText: 'Digite a descrição do produto',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: null,
                          onSaved: (desc) => widget.product.descricao = desc,
                        ),
                      TextFormField(
                        initialValue: widget.product.preco?.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Preço',
                            hintText: 'Digite o preço',
                          prefixText: 'R\$ '
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        validator: (pr){
                          if(num.tryParse(pr)==null)
                            return 'Preço Inválido!';
                          return null;
                        },
                        onSaved: (p) => widget.product.preco = num.tryParse(p),
                      ),
                      SizedBox(height: 25,),
                      Text('Escolha a categoria: ',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Consumer<CategoryManager>(
                        builder: (_, categoryManager, __){
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: categoryManager.allCategories.length,
                              itemBuilder: (_, index){
                                if(categoryManager.allCategories[index].nome == widget.product.categoria)
                                  selectedIndex = index;
                                return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      widget.product.categoria = categoryManager.allCategories[index].nome;
                                      widget.product.categoriaid = categoryManager.allCategories[index].id;
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: selectedIndex == index ? Colors.black : Colors.transparent,
                                              ),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(selectedIndex == index ? Icons.arrow_right : null),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      '${categoryManager.allCategories[index].nome}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  );
                              }
                          );
                        },
                      ),
                      Consumer<Product>(
                        builder: (_, product, __){
                        return Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                  onPressed: () async {

                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();

                                      await product.save();

                                      //avisar ao productmanager que houve mudanca num produto para ele poder refazer a tela
                                      context.read<ProductManager>().update(product);

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
                                  onPressed: () async {
                                    VoidCallback continueCallBack = () {
                                      product.delete();

                                      //avisar ao productmanager que houve mudanca num produto para ele poder refazer a tela
                                      context.read<ProductManager>().delete(product);

                                      Navigator.of(context).pop();
                                    };
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return CustomAlertDialog(
                                              'Excluir',
                                              'Deseja realmente excluir o Produto?',
                                              continueCallBack
                                          );
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

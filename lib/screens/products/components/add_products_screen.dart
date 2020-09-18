import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/product.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductsScreen extends StatefulWidget {

  AddProductsScreen({Product p}){
    p = product;
  }

  final Product product = Product();

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Adicionar produto'),
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
                        decoration: const InputDecoration(
                          labelText: 'Nome do produto',
                          hintText: 'Digite o nome do produto',
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
                        onSaved: (name) => widget.product.nome = name,
                      ),
                      TextFormField(
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
                            return 'Inválido';
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
                            return FlatButton(
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
                          color: Colors.red,
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

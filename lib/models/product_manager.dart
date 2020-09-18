import 'package:atividade_rebuut/models/category.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductManager extends ChangeNotifier{

  ProductManager(){
    _loadAllProducts();
  }

  CategoryManager categoryManager;

  Category category;

  Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];
  List<Product> toRemove = [];


  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('produtos').getDocuments();

    //pega todos os documentos e transforma em objeto do tipo product e depois numa lista
    allProducts = snapProducts.documents.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  void update(Product product){
    //remove o pproduto antigo ( antes de clonar )
    allProducts.removeWhere((p) => p.id == product.id);
    //depois adiciona o atualizado
    allProducts.add(product);
    notifyListeners();
  }

  Future<void> updateCat(Category category) async {
    for(final prod in allProducts){
      if(prod.categoriaid == category.id){
        prod.categoria = category.nome;
        await prod.save();
        allProducts.removeWhere((element) => element.categoriaid == category.id);
        allProducts.add(prod);
      }
    }
    notifyListeners();
  }

  void deletedCat(Category category) {

    for(final prod in allProducts){
      if(prod.categoriaid == category.id){
        toRemove.add(prod);
        prod.delete();
      }
    }

    allProducts.removeWhere((p) => toRemove.contains(p));
    notifyListeners();
  }

  void delete(Product product) {
    product.delete();
    allProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }
}
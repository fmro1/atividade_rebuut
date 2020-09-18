import 'package:atividade_rebuut/models/category.dart';
import 'package:atividade_rebuut/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryManager extends ChangeNotifier{

  CategoryManager(){
    _loadAllCategories();
  }

  Firestore firestore = Firestore.instance;

  List<Category> allCategories = [];

  Future<void> _loadAllCategories() async {
    final QuerySnapshot snapProducts = await firestore.collection('categorias').getDocuments();

    //pega todos os documentos e transforma em objeto do tipo category e depois numa lista
    allCategories = snapProducts.documents.map((d) => Category.fromDocument(d)).toList();

    notifyListeners();
  }

  void update(Category category){
    //remove a categoria antiga
    allCategories.removeWhere((c) => c.id == category.id);
    //depois adiciona o atualizado
    allCategories.add(category);
    notifyListeners();
  }

  void delete(Category category) {
    category.delete();
    allCategories.removeWhere((p) => p.id == category.id);
    notifyListeners();
  }
}
import 'package:atividade_rebuut/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'category_manager.dart';

class Product extends ChangeNotifier{

  Product({this.id, this.nome, this.preco, this.descricao, this.categoria, this.categoriaid});


  final Firestore firestore = Firestore.instance;
  //obtendo o documento relativo ao produto criado
  DocumentReference get firestoreRef => firestore.document('produtos/$id');
  DocumentReference get firestoreRefCat => firestore.document('categorias/$id');

  String id;
  String nome;
  num preco;
  String descricao;
  String categoria;
  String categoriaid;


  Product.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    nome = document['nome'] as String;
    descricao = document['descricao'] as String;
    preco = document['preco'] as num;
    categoria = document['categoria'] as String;
    categoriaid = document['categoriaid'] as String;
  }

  Future<void> save() async {
    final Map<String, dynamic> data = {
      'nome' : nome,
      'descricao' : descricao,
      'preco' : preco,
      'categoria': categoria,
      'categoriaid': categoriaid
    };

    if(id == null){
      //se for criação de produco cria um novo e salva na DB
      final doc = await firestore.collection('produtos').add(data);
      //pega o id desse produto criado
      id = doc.documentID;
    } else {
      //update atualiza os dados e se nao tiver algum dado passado, o dado que ja esta
      //na database se mantem. Se colocasse setData, reescreveria todos os dados
      await firestoreRef.updateData(data);

    }
  }

  void delete(){
    firestoreRef.delete();
  }

  //fazer copia para poder alterar os dados sem mudar o objeto base
  Product clone(){
    return Product(
      id: id,
      nome: nome,
      descricao: descricao,
      preco: preco,
      categoria: categoria,
      categoriaid: categoriaid
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, nome: $nome, preco: $preco, descricao: $descricao, categoria: $categoria}';
  }
}
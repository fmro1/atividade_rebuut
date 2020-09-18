import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Category extends ChangeNotifier{

  Category({this.id, this.nome});

  String id;
  String nome;

  final Firestore firestore = Firestore.instance;
  //obtendo o documento relativo ao produto criado
  DocumentReference get firestoreRef => firestore.document('categorias/$id');


  Category.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    nome = document['nome'] as String;
  }

  Future<void> save() async {
    final Map<String, dynamic> data = {
      'nome' : nome,
    };

    if(id == null){
      //se for criação de produco cria um novo e salva na DB
      final doc = await firestore.collection('categorias').add(data);
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
}
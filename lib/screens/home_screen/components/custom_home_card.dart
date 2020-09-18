import 'package:atividade_rebuut/models/page_manager.dart';
import 'package:atividade_rebuut/screens/categories/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomHomeCard extends StatelessWidget {

  CustomHomeCard({@required this.page, this.title, this.bodyText});

  final int page;
  final String title;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<PageManager>().setPage(page);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
            padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text('$title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
              ),
              SizedBox(height: 8,),
              Text('$bodyText',
                style: TextStyle(
                fontSize: 16,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

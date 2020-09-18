import 'package:atividade_rebuut/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {

  ProductTile({this.title, this.icon, this.page});

  final String title;
  final IconData icon;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          context.read<PageManager>().setPage(page);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          height: 30.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 18.0,
                //color: Colors.white,
              ),
              const SizedBox(width: 32.0,),
              Text(
                '$title',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    //color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

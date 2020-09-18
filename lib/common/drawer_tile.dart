import 'package:atividade_rebuut/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({this.icon, this.text, this.page});

  final IconData icon;
  final String text;
  final int page;

  @override
  Widget build(BuildContext context) {

    final int curPage = context.watch<PageManager>().page;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          context.read<PageManager>().setPage(page);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          height: 60.0,
          child: Row(
              children: [
                Icon(
                  icon,
                  size: 32.0,
                  color: curPage == page ? Theme.of(context).primaryColor : Colors.grey[700],
                ),
                const SizedBox(width: 32.0,),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: curPage == page ? Theme.of(context).primaryColor : Colors.grey[700],
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}

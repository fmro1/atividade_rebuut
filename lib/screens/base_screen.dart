
import 'package:atividade_rebuut/models/page_manager.dart';
import 'package:atividade_rebuut/screens/categories/categories_screen.dart';
import 'package:atividade_rebuut/screens/categories/components/add_categories_screen.dart';
import 'package:atividade_rebuut/screens/products/components/add_products_screen.dart';
import 'package:atividade_rebuut/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen/home_screen.dart';

class BaseScreen extends StatelessWidget {

  final PageController pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pagecontroller),
      child: PageView(
        controller: pagecontroller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CategoriesScreen(),
          ProductsScreen(),
          AddCategoriesScreen(),
          AddProductsScreen(),
        ]
      ),
    );
  }
}

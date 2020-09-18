import 'package:atividade_rebuut/models/category.dart';
import 'package:atividade_rebuut/models/category_manager.dart';
import 'package:atividade_rebuut/models/product.dart';
import 'package:atividade_rebuut/models/product_manager.dart';
import 'package:atividade_rebuut/screens/base_screen.dart';
import 'package:atividade_rebuut/screens/categories/categories_screen.dart';
import 'package:atividade_rebuut/screens/categories/category_screen.dart';
import 'package:atividade_rebuut/screens/categories/components/add_categories_screen.dart';
import 'package:atividade_rebuut/screens/categories/components/edit_category_screen.dart';
import 'package:atividade_rebuut/screens/products/components/add_products_screen.dart';
import 'package:atividade_rebuut/screens/products/components/edit_product_screen.dart';
import 'package:atividade_rebuut/screens/products/product_screen.dart';
import 'package:atividade_rebuut/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          lazy: false,
        ),
        /*ProxyProvider<CategoryManager, ProductManager>(
            create: (_) => ProductManager(),
          lazy: false,
          update: (_, categoryManager, productManager) =>
          productManager..updateCategory(categoryManager),
        ),*/

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
              elevation: 0
          )
        ),
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/categorias':
              return MaterialPageRoute(
                  builder: (_) => CategoriesScreen()
              );
            case '/categoria':
              return MaterialPageRoute(
                  builder: (_) => CategoryScreen(
                    settings.arguments as Category
                  )
              );
            case '/add_categoria':
              return MaterialPageRoute(
                  builder: (_) => AddCategoriesScreen()
              );
            case '/editar_categoria':
              return MaterialPageRoute(
                builder: (_) => EditCategoryScreen(
                  settings.arguments as Category
                )
            );
            case '/produtos':
              return MaterialPageRoute(
                  builder: (_) => ProductsScreen()
              );
            case '/produto':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/editar_produto':
              return MaterialPageRoute(
                  builder: (_) => EditProductScreen(
                      settings.arguments as Product)
              );
            case '/add_produto':
              return MaterialPageRoute(
                builder: (_) => AddProductsScreen()
            );
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
                settings: settings
              );
          }
        },
      ),
    );
  }
}


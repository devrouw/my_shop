import 'package:flutter/material.dart';
import 'package:my_shop/models/products.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFav;

  const ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Product>(context);
    final loadedProducts = showFav ? productsData.filteredItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value:loadedProducts[i],
        child: ProductItem(
//          id: loadedProducts[i].id,
//          title: loadedProducts[i].title,
//          imageUrl: loadedProducts[i].imageUrl,
        ),
      ),
    );
  }
}

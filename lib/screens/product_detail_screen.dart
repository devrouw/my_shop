import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
//    final productsData = Provider.of<Product>(context);
//    final loadedProducts = productsData.items;
    final products =
        Provider.of<Product>(context, listen: false).getById(productId);
    //...
    return Scaffold(
//      appBar: AppBar(
//        title: Text(products.title),
//      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(products.title),
              background: Hero(
                tag: products.id,
                child: Image.network(
                  products.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${products.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                products.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 800,),
          ]))
        ],
//        child: Column(
//          children: [
//            Container(
//              height: 300,
//              width: double.infinity,
//              child: Hero(
//                tag: products.id,
//                child: Image.network(
//                  products.imageUrl,
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ],
//        ),
      ),
    );
  }
}

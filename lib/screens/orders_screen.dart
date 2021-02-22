import 'package:flutter/material.dart';
import 'package:my_shop/models/orders.dart' show Orders;
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;

  Future _obtainOrdersFuture(){
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ordersFuture = _obtainOrdersFuture();
  }

  @override
  Widget build(BuildContext context) {
//    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapShot.error != null) {
              return Center(
                child: Text('An Error Occurred!'),
              );
            } else {
              return Consumer<Orders>(
                  builder: (ctx, orders, child) => ListView.builder(
                        itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
                        itemCount: orders.orders.length,
                      ));
            }
          }
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_shop/models/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cart;
  final DateTime dateTime;

  OrderItem(this.id, this.amount, this.cart, this.dateTime);
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url =
        'https://flutter-update-5436e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null){
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        orderId,
        orderData['amount'],
        (orderData['cart'] as List<dynamic>)
            .map(
              (data) => CartItem(
                data['id'],
                data['title'],
                data['qty'],
                data['price'],
              ),
            )
            .toList(),
        DateTime.parse(orderData['dateTime']),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-update-5436e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'cart': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'qty': cp.qty,
                    'price': cp.price,
                  })
              .toList(),
          'dateTime': timestamp.toIso8601String(),
        }));
    _orders.insert(
      0,
      OrderItem(
        json.decode(response.body)['name'],
        total,
        cartProducts,
        timestamp,
      ),
    );
    notifyListeners();
  }
}

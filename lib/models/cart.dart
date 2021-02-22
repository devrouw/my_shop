import 'package:flutter/foundation.dart';
import 'package:my_shop/models/products.dart';

class CartItem {
  final String id;
  final String title;
  final int qty;
  final double price;

  CartItem(this.id, this.title, this.qty, this.price);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.qty;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
          value.id,
          value.title,
          value.qty + 1,
          value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          DateTime.now().toString(),
          title,
          1,
          price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].qty > 1) {
      _items.update(
          productId,
          (existing) => CartItem(
                existing.id,
                existing.title,
                existing.qty - 1,
                existing.price,
              ));
    }else{
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

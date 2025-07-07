import 'package:flutter/material.dart';
import 'package:beautysalon/components/procedure.dart';

class CartProvider with ChangeNotifier{
  final List<Procedure> _items = [];

  List<Procedure> get items =>_items;

  Map<Procedure, int> get groupedItems{
    final map = <Procedure, int>{};
    for (var item in _items){
      map[item] = (map[item]??0)+1;
    }
    return map;
  }

  //add to cart
  void addToCart(Procedure procedure, int quantity) {
    for (int i=0; i<quantity; i++) {
      _items.add(procedure);
    }
    debugPrint('Добавлено в корзину: ${procedure.title}, всего: ${_items.length}'); 
    notifyListeners();
  }

  //remove from cart
  void removeFromCart(Procedure procedure){
    _items.remove(procedure);
    notifyListeners();
  }
  //clear cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  

  //total worth
  double get totalPrice{
    return _items.fold(0,(sum,item)=>sum+item.price);
  }
}
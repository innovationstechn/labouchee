import 'dart:async';

import 'package:labouchee/app/locator.dart';
import 'package:labouchee/models/cart.dart';
import 'package:labouchee/models/cart_item.dart';
import 'package:labouchee/services/cart_service.dart';
import 'package:labouchee/utils/product_size.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartVM extends BaseViewModel {
  final _cartService = locator<CartService>();
  final _snackbarService = locator<SnackbarService>();
  final _cartStream = StreamController<CartModel>();

  Stream<CartModel> get cart => _cartStream.stream;

  CartVM() : super() {
    _cartService.cartState.listen((event) {
      _cartStream.add(event);
    }, onError: (e) {
      setError(e);
    });
  }

  void sync() => _cartService.syncCart();

  void remove(CartItemModel item, String size) => _cartService.removeItem(
        item.id!,
        size: size,
      );

  void increase(int id, int quantity, String size) {
    _cartService.addItem(
      id,
      quantity,
      sizeInEnum: productFromString(size),
    );
  }

  void decrease(int id, int quantity, String size) => _cartService.decreaseItem(
        id,
        quantity,
        sizeInEnum: productFromString(size),
      );
}

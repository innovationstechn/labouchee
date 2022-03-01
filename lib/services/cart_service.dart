import 'dart:async';

import 'package:labouchee/models/cart.dart';
import 'package:labouchee/models/cart_update.dart';
import 'package:labouchee/services/api/api.dart';
import 'package:labouchee/services/api/labouchee_api.dart';
import 'package:labouchee/utils/product_size.dart';

import '../app/locator.dart';

class CartService {
  final API _api = locator<LaboucheeAPI>();

  final StreamController<CartModel> _cartStreamController =
      StreamController.broadcast();

  Stream<CartModel> get cartState => _cartStreamController.stream;

  Future<void> syncCart() async {
    try {
      _cartStreamController.add(
        await _api.getCart(),
      );
    } catch (e) {
      _cartStreamController.addError(
        e.toString(),
      );
    }
  }

  Future<String> removeItem(int id, {String? size}) async {
    final message = await _api.updateCart(
      CartUpdateModel(
        product: id,
        size: size,
        type: 'remove',
      ),
    );

    await syncCart();

    return message;
  }

  Future<String> addItem(int product, int quantity, {ProductSize? sizeInEnum, String? sizeInText}) async {
    final message = await _api.updateCart(
      CartUpdateModel(
        product: product,
        quantity: quantity,
        size: sizeInText ?? productSizeToString(sizeInEnum!),
        type: 'add',
      ),
    );

    await syncCart();

    return message;
  }

  Future<String> decreaseItem(int product, int quantity, {ProductSize? sizeInEnum, String? sizeInText}) async {
    final message = await _api.updateCart(
      CartUpdateModel(
        product: product,
        quantity: quantity,
        size: sizeInText ?? productSizeToString(sizeInEnum!),
        type: 'sub',
      ),
    );

    await syncCart();

    return message;
  }
}

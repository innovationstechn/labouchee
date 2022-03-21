import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:labouchee/app/routes.gr.dart';
import 'package:labouchee/models/apply_coupon.dart';
import 'package:labouchee/models/branch.dart';
import 'package:labouchee/models/cart_detail.dart';
import 'package:labouchee/models/order.dart';
import 'package:labouchee/models/shipping_location.dart';
import 'package:labouchee/pages/place_order/place_order.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:xml/xml.dart';
import 'package:sdk/components/network_helper.dart';
import 'package:sdk/screens/webview_screen.dart';

import '../../app/locator.dart';
import '../../constants/strings.dart';
import '../../models/TelrPaymentModel.dart';
import '../../models/place_order.dart';
import '../../models/place_order_error.dart';
import '../../models/user.dart';
import '../../services/api/exceptions/api_exceptions.dart';
import '../../services/api/labouchee_api.dart';
import '../../services/language_service.dart';
import '../../services/local_storage/hive_local_storage.dart';
import '../../services/navigator.dart';
import '../../services/user_service.dart';
import '../../utils/helpers.dart';

class PlaceOrderVM extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _api = locator<LaboucheeAPI>();
  final _navigationService = locator<NavigatorService>();
  final _localStorage = locator<HiveLocalStorage>();

  List<BranchModel> _branches = [];

  List<BranchModel> get branches => _branches;

  List<ShippingLocationModel> _locations = [];

  List<ShippingLocationModel> get locations => _locations;

  CartDetailModel? _cart;

  UserModel? user;
  Locale? _locale;

  Future<void> initialize() async {
    Future<void> _initialize() async {
      try {
        user = await _api.getUser();
        _branches = await _api.getBranches();
        _locations = await _api.getShippingLocations();
        _cart = await _api.getDetailedCart();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_initialize());
  }

  Future<void> placeOrder(
    String name,
    String phone,
    int? city,
    String email,
    PaymentMethod paymentMethod,
    int? branch,
    String addr1,
    String? addr2,
    String? bookingDate,
    String? bookingTime,
    String? notes,
  ) async {
    final PlaceOrderModel order = PlaceOrderModel(
      name: name,
      phone: phone,
      city: city,
      email: email,
      paymentMethod: paymentMethod,
      branch: branch,
      addr1: addr1,
      addr2: addr2,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      orderNote: notes,
    );

    switch (paymentMethod) {
      case PaymentMethod.digital:
        {
          await payUsingDigital(order);
        }
        break;
      case PaymentMethod.cashOnDelivery:
      case PaymentMethod.pickup:
      case PaymentMethod.mada:
        {
          onPayment(order);
        }
    }
  }

  void onPayment(PlaceOrderModel order) async {
    try {
      final message = await _api.placeOrder(order);
      _snackbarService.showSnackbar(message: message);
      _navigationService.router.popUntilRoot();
      _navigationService.router.pop();
      _navigationService.router.navigate(MyOrdersScreenRoute());
    } catch (e) {
      if (e is ErrorModelException) {
        setError(e.error as PlaceOrderErrorModel);
        _snackbarService.showSnackbar(message: e.message);
      } else {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }
  }

  Future<void> payUsingDigital(PlaceOrderModel order) async {
    String platform = '';
    String? deviceId = await uniqueDeviceIdentifier();
    String? locale = await _localStorage.locale();

    if (Platform.isAndroid) {
      platform = 'Android';
    } else {
      platform = 'iOS';
    }

    telrPayment(
      TelrPaymentModel(
        storeId: '26550',
        key: '9F2sv-N8hFS@zKdS',
        deviceType: platform,
        deviceId: deviceId!,
        appName: 'Labouchee',
        userId: user!.id!.toString(),
        description: _cart!.cart!.items.toString(),
        currency: 'SAR',
        amount: _cart!.cartInfo!.totalPrice!.toString(),
        language: locale!,
        userName: '',
        userFirstName: order.name!,
        userSecondName: '',
        address: order.addr1!,
        city: order.city!.toString(),
        region: order.city!.toString(),
        country: 'Saudia Arabia',
        userPhoneNumber: order.phone!,
        email: order.email!,
      ),
      order,
    );
  }

  void displayMessage(String message) {
    _snackbarService.showSnackbar(message: message);
  }

  void telrPayment(TelrPaymentModel telrPaymentModel, PlaceOrderModel order) {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text(telrPaymentModel.storeId);
      });
      builder.element('key', nest: () {
        builder.text(telrPaymentModel.key);
      });

      builder.element('device', nest: () {
        builder.element('type', nest: () {
          builder.text(telrPaymentModel.deviceType);
        });
        builder.element('id', nest: () {
          builder.text(telrPaymentModel.deviceId);
        });
      });

      // app
      builder.element('app', nest: () {
        builder.element('name', nest: () {
          builder.text('Telr');
        });
        builder.element('version', nest: () {
          builder.text('1.1.6');
        });
        builder.element('user', nest: () {
          builder.text('2');
        });
        builder.element('id', nest: () {
          builder.text('123');
        });
      });

      //tran
      builder.element('tran', nest: () {
        builder.element('test', nest: () {
          builder.text('0');
        });
        builder.element('type', nest: () {
          builder.text('auth');
        });
        builder.element('class', nest: () {
          builder.text('paypage');
        });
        builder.element('cartid', nest: () {
          builder.text(Random().nextInt(100000));
        });
        builder.element('description', nest: () {
          builder.text(telrPaymentModel.description);
        });
        builder.element('currency', nest: () {
          builder.text(telrPaymentModel.currency);
        });
        builder.element('amount', nest: () {
          builder.text(telrPaymentModel.amount);
        });
        builder.element('language', nest: () {
          builder.text(telrPaymentModel.language);
        });
        builder.element('firstref', nest: () {
          builder.text('first');
        });
        builder.element('ref', nest: () {
          builder.text('null');
        });
      });

      //billing
      builder.element('billing', nest: () {
        // name
        builder.element('name', nest: () {
          builder.element('title', nest: () {
            builder.text('');
          });
          builder.element('first', nest: () {
            builder.text('');
          });
          builder.element('last', nest: () {
            builder.text(telrPaymentModel.userName);
          });
        });
        //custref savedcard
        builder.element('custref', nest: () {
          builder.text('231');
        });

        // address
        builder.element('address', nest: () {
          builder.element('line1', nest: () {
            builder.text(telrPaymentModel.address);
          });
          builder.element('city', nest: () {
            builder.text(telrPaymentModel.city);
          });
          builder.element('region', nest: () {
            builder.text('ME');
          });
          builder.element('country', nest: () {
            builder.text(telrPaymentModel.country);
          });
        });

        builder.element('phone', nest: () {
          builder.text(telrPaymentModel.userPhoneNumber);
        });
        builder.element('email', nest: () {
          builder.text(telrPaymentModel.email);
        });
      });
    });

    final bookshelfXml = builder.buildDocument();
    pay(bookshelfXml, order);
  }

  void pay(XmlDocument xml, PlaceOrderModel order) async {
    NetworkHelper _networkHelper = NetworkHelper();
    var response = await _networkHelper.pay(xml);
    print(response);
    if (response == 'failed' || response == null) {
      // failed
      //       alertShow('Failed');
    } else {
      var _url;
      final doc = XmlDocument.parse(response);
      final url = doc.findAllElements('start').map((node) => node.text);
      final code = doc.findAllElements('code').map((node) => node.text);
      print(url);
      _url = url.toString();
      String _code = code.toString();
      if (_url.length > 2) {
        _url = _url.replaceAll('(', '');
        _url = _url.replaceAll(')', '');
        _code = _code.replaceAll('(', '');
        _code = _code.replaceAll(')', '');
        _launchURL(_url, _code, order);
      }
      print(_url);
      final message = doc.findAllElements('message').map((node) => node.text);
      print('Message =  $message');
      if (message.toString().length > 2) {
        String msg = message.toString();
        msg = msg.replaceAll('(', '');
        msg = msg.replaceAll(')', '');
        // alertShow(msg);
      }
    }
  }

  void _launchURL(String url, String code, PlaceOrderModel order) async {
    _navigationService.router.pushWidget(
      WebViewScreen(
        url: url,
        code: code,
        onResponse: (bool success, String xml) {
          if (success) {
            onPayment(order..telr = xml);
          } else {
            _snackbarService.showSnackbar(
              message: Strings.paymentProcessError,
            );
          }
        },
      ),
    );
  }
}

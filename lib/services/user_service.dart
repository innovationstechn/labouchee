import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:labouchee/models/update_profile.dart';
import 'package:labouchee/models/user.dart';
import 'package:labouchee/services/api/api.dart';
import 'package:labouchee/services/api/exceptions/api_exceptions.dart';
import 'package:labouchee/services/api/labouchee_api.dart';

import '../app/locator.dart';

class UserService {
  final API _api = locator<LaboucheeAPI>();

  final StreamController<UserModel> _userStreamController =
      StreamController.broadcast();

  Stream<UserModel> get userState => _userStreamController.stream;

  Future<void> fetch() async {
    try {
      final user = await _api.getUser();

      _userStreamController.add(user);
    } catch (e) {
      _userStreamController.addError(e);
    }
  }

  Future<String> update(UpdateProfileModel model) async {
    try {
      final message = await _api.updateProfile(model);

      await fetch();

      return message;
    } catch (e) {
      _userStreamController.addError(
        e,
      );

      if (e is ErrorModelException) {
        return e.message;
      }

      return e.toString();
    }
  }
}

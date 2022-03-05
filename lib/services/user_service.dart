import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:labouchee/models/update_profile.dart';
import 'package:labouchee/models/user.dart';
import 'package:labouchee/services/api/api.dart';
import 'package:labouchee/services/api/labouchee_api.dart';

import '../app/locator.dart';

class UserService {
  final API _api = locator<LaboucheeAPI>();

  final StreamController<UserModel> _userStreamController =
      StreamController.broadcast();

  Stream<UserModel> get userState => _userStreamController.stream;

  Future<void> fetch() async {
    try {
      _userStreamController.add(
        await _api.getUser(),
      );
    } catch (e) {
      _userStreamController.addError(
        e.toString(),
      );
    }
  }

  Future<String> update(UpdateProfileModel model) async {
    try {
      final message = await _api.updateProfile(model);

      await fetch();

      return message;
    } catch (e) {
      _userStreamController.addError(
        e.toString(),
      );

      return e.toString();
    }
  }
}

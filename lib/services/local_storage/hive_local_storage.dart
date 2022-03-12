import 'package:hive/hive.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';

class HiveLocalStorage implements LocalStorage {
  static Box? _prefsBox;

  static Future<void> init() async {
    _prefsBox = await Hive.openBox('storage');
  }

  @override
  Future<bool> onboardingDone({bool? isDone}) async {
    if (isDone != null) {
      await _prefsBox!.put('onboarding_done', isDone);
    }

    return Future.delayed(
      Duration.zero,
      () => _prefsBox!.get('onboarding_done') ?? false,
    );
  }

  @override
  Future<String?> locale({String? localeString}) async {
    if (localeString != null) {
      await _prefsBox!.put('locale', localeString);
    }

    return Future.delayed(
      Duration.zero,
      () => _prefsBox!.get('locale'),
    );
  }

  @override
  Future<String?> token({String? token}) async {
    if (token != null) {
      await _prefsBox!.put('token', token);
    }

    return Future.delayed(
      Duration.zero,
      () => _prefsBox!.get('token'),
    );
  }

  @override
  Future<bool> isOtpVerified({bool? isVerified}) async {
    if (isVerified != null) {
      await _prefsBox!.put('otp_verified', isVerified);
    }

    return Future.delayed(
      Duration.zero,
      () => _prefsBox!.get('otp_verified') ?? false,
    );
  }

  @override
  Future<void> clearToken() async {
    await _prefsBox!.delete('token');
  }
}

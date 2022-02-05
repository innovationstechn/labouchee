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
}

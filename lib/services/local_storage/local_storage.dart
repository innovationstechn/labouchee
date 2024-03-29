abstract class LocalStorage {
  Future<bool> onboardingDone({bool? isDone});
  Future<String?> locale({String? localeString});
  Future<String?> token({String? token});
  Future<void> clearToken();
  Future<bool> isOtpVerified({bool? isVerified});
}

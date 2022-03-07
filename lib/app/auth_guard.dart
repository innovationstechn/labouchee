import 'package:auto_route/auto_route.dart';
import 'package:labouchee/app/locator.dart';
import '../utils/helpers.dart';
import 'package:labouchee/services/local_storage/local_storage.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final initRoute = await generateInitRoute();
    router.replaceAll([initRoute]);
  }
}

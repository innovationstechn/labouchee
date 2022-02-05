import 'package:flutter/material.dart';
import 'package:labouchee/widgets/setup_bottom_sheet_ui.dart';
import 'package:labouchee/widgets/setup_dialog_ui.dart';
import 'package:labouchee/widgets/setup_snackbar_ui.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'app/routes.gr.dart' as auto_router;
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';

void main() {
  setupLocator();
  setupDialogUi();
  setupSnackbarUi();
  setupBottomSheetUi();

  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp(),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        localizationsDelegates:  const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        navigatorObservers: [
          StackedService.routeObserver,
          // _LoggingObserver(),
        ],
        navigatorKey: StackedService.navigatorKey,
        initialRoute: auto_router.Routes.loginScreenRoute,
        onGenerateRoute: auto_router.Router().onGenerateRoute,
        theme: ThemeData(primaryColor: const Color.fromRGBO(80, 32, 10, 1)),
        title: 'Flutter Demo',
      );
    });

  }
}
//
// class _LoggingObserver extends NavigatorObserver {
//   @override
//   void didPop(Route route, Route previousRoute) {
//     print(
//         'route.name: ${route?.settings?.name}, previousRoute.name: ${previousRoute?.settings?.name}');
//     super.didPop(route, previousRoute);
//   }
//
//   @override
//   void didRemove(Route route, Route previousRoute) {
//     print(
//         'route.name: ${route?.settings?.name}, previousRoute.name: ${previousRoute?.settings?.name}');
//     super.didRemove(route, previousRoute);
//   }
//
//   @override
//   void didPush(Route route, Route previousRoute) {
//     print(
//         'route.name: ${route?.settings?.name}, previousRoute.name: ${previousRoute?.settings?.name}');
//     super.didPush(route, previousRoute);
//   }
//
//   @override
//   void didReplace({Route newRoute, Route oldRoute}) {
//     print(
//         'newRoute.name: ${newRoute?.settings?.name}, oldRoute.name: ${oldRoute?.settings?.name}');
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:labouchee/constants/general.dart';
import 'package:labouchee/language_view_model.dart';
import 'package:labouchee/services/local_storage/hive_local_storage.dart';
import 'package:labouchee/services/navigator.dart';
import 'package:labouchee/services/security.dart';
import 'package:labouchee/utils/helpers.dart';
import 'package:labouchee/widgets/setup_bottom_sheet_ui.dart';
import 'package:labouchee/widgets/setup_dialog_ui.dart';
import 'package:labouchee/widgets/setup_snackbar_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'app/routes.gr.dart' as auto_router;
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  final pass = await verification();

  if (!pass) return;

  setupLocator();
  setupDialogUi();
  setupSnackbarUi();
  setupBottomSheetUi();

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveLocalStorage.init();

  final PageRouteInfo initialRoute = await generateInitRoute();

  runApp(
    MyApp(
      initialRoute: initialRoute,
    ),
  );
}

class MyApp extends StatelessWidget {
  final PageRouteInfo initialRoute;
  final NavigatorService _navigatorService = locator<NavigatorService>();

  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ViewModelBuilder<LanguageVM>.reactive(
          viewModelBuilder: () => LanguageVM(),
          builder: (context, languageVM, _) {
            return MaterialApp.router(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: languageVM.locale,
              supportedLocales: L10n.all,
              routerDelegate: _navigatorService.router
                  .delegate(initialRoutes: [initialRoute]),
              theme: ThemeData(
                  primaryColor: const Color.fromRGBO(80, 32, 10, 1),
                  fontFamily: languageVM.locale.languageCode == "en"
                      ? "ExoRegular"
                      : 'DaxMedium'),
              title: 'Flutter Demo',
              routeInformationParser:
                  _navigatorService.router.defaultRouteParser(),
            );
          },
        );
      },
    );
  }
}

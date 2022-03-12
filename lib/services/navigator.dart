import 'package:stacked_services/stacked_services.dart';

import '../app/routes.gr.dart' as auto_router;

class NavigatorService {
  final auto_router.Router _router =
      auto_router.Router(StackedService.navigatorKey);

  auto_router.Router get router => _router;
}

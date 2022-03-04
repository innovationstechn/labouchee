import '../app/routes.gr.dart' as auto_router;

class NavigatorService {
  final auto_router.Router _router = auto_router.Router();

  auto_router.Router get router => _router;
}

import 'package:labouchee/models/mark_read_notification.dart';
import 'package:labouchee/models/notification.dart';
import 'package:labouchee/models/notification_filter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../services/api/labouchee_api.dart';

class NotificationsVM extends BaseViewModel {
  final _laboucheeAPI = locator<LaboucheeAPI>();
  final _snackbarService = locator<SnackbarService>();

  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  Future<void> loadData() async {
    Future<void> _loadData() async {
      try {
        _notifications = await _laboucheeAPI.getNotifications(
          NotificationFilterModel(seen: 0, type: 'order'),
        );
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_loadData());
  }

  Future<void> markNotificationsAsRead(List<int> ids) async {
    Future<void> _markNotificationsAsRead() async {
      try {
        final message = await _laboucheeAPI.markNotificationAsRead(
          MarkReadNotificationModel(notification: ids),
        );

        _snackbarService.showSnackbar(message: message);

        await loadData();
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      }
    }

    await runBusyFuture(_markNotificationsAsRead());
  }
}

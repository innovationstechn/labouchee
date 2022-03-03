import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labouchee/models/notification.dart';
import 'package:labouchee/pages/notifications/notifications_viewmodel.dart';
import 'package:labouchee/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

class Notifications extends StatelessWidget {
  Notifications({Key? key}) : super(key: key);
  final List<String> text = [
    "You have place an order.Your order is under review",
    "You have place an order.Your order is under review",
    "You have place an order.Your order is under review"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ViewModelBuilder<NotificationsVM>.reactive(
        viewModelBuilder: () => NotificationsVM(),
        onModelReady: (model) => model.loadData(),
        builder: (context, notificationsVM, _) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return notificationCard(
                notificationsVM.notifications[index],
                notificationsVM.markNotificationsAsRead,
              );
            },
            itemCount: notificationsVM.notifications.length,
          );
        },
      ),
    );
  }

  Widget notificationCard(NotificationModel notification, void Function(List<int>) onTap) {
    return GestureDetector(
      onTap: () => onTap([notification.id!]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: notification.notification?.message ?? "",
                  maxLines: 10,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: "Created at ${notification.createdDate ?? '-'}",
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

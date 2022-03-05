import 'package:flutter/material.dart';
import 'package:labouchee/models/my_order.dart';
import 'package:labouchee/pages/my_order_detail/my_order_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MyOrderDetailPage extends StatelessWidget {
  final MyOrderModel order;

  MyOrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<MyOrderDetailVM>.reactive(
        viewModelBuilder: () => MyOrderDetailVM(order: order),
        onModelReady: (model) => model.loadData(),
        builder: (context, detailVM, _) {
          return Container();
        },
      ),
    );
  }
}

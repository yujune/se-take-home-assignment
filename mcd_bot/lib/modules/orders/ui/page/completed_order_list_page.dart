import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';
import 'package:mcd_bot/modules/orders/ui/view_model/pending_order_list_view_model.dart';
import 'package:mcd_bot/modules/orders/ui/widget/oder_list.dart';
import 'package:provider/provider.dart';

class CompletedOrderListPage extends StatelessWidget {
  const CompletedOrderListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<OrderListViewModel, List<Order>>(
      selector: (_, pendingOrderListViewModel) =>
          pendingOrderListViewModel.completedOrderList,
      builder: (context, orderList, child) => OrderList(
        data: orderList,
      ),
    );
  }
}

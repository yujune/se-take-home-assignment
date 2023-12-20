import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/bots/view_model/bot_view_model.dart';
import 'package:mcd_bot/modules/orders/constant.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';
import 'package:mcd_bot/modules/orders/ui/view_model/pending_order_list_view_model.dart';
import 'package:mcd_bot/modules/orders/ui/widget/oder_list.dart';
import 'package:mcd_bot/modules/orders/ui/widget/pending_order_bottom_bar.dart';
import 'package:provider/provider.dart';

class PendingOrderListPage extends StatelessWidget {
  const PendingOrderListPage({
    super.key,
  });

  void _onAddOrderPressed({
    required BuildContext context,
    required OrderType orderType,
  }) {
    final order = Order.newOrder(type: orderType);
    final pendingOrderListViewModel = context.read<OrderListViewModel>();
    pendingOrderListViewModel.addOrder(order);

    final botListViewModel = context.read<BotListViewModel>();
    botListViewModel.checkAvailabilityAndProcessOrder(orderId: order.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Selector<OrderListViewModel, List<Order>>(
      selector: (_, pendingOrderListViewModel) =>
          pendingOrderListViewModel.pendingOrderList,
      child: PendingOrderBottomBar(
        onAddVipOrderPressed: () => _onAddOrderPressed(
          context: context,
          orderType: OrderType.vip,
        ),
        onAddNormalOrderPressed: () => _onAddOrderPressed(
          context: context,
          orderType: OrderType.normal,
        ),
      ),
      builder: (context, pendingOrderList, child) {
        return Scaffold(
          body: OrderList(data: pendingOrderList),
          bottomNavigationBar: child,
        );
      },
    );
  }
}

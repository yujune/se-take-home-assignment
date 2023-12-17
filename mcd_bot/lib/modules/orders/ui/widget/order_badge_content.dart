import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/orders/constant.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';

class OrderBadgeContent extends StatelessWidget {
  final Order order;
  const OrderBadgeContent({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    if (order.status?.isCompleted == true) {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 25,
      );
    }

    if (order.type?.isVip == true) {
      return Text(
        OrderType.vip.name.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 10),
      );
    }

    return const SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mcd_bot/modules/orders/ui/widget/order_badge_content.dart';

class OrderBadge extends StatelessWidget {
  final Order order;
  const OrderBadge({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      badgeContent: OrderBadgeContent(order: order),
      badgeStyle: badges.BadgeStyle(
        badgeColor:
            order.status?.isCompleted == true ? Colors.white : Colors.amber,
      ),
      showBadge: order.type?.isVip == true || order.status?.isCompleted == true,
      child: const Icon(
        Icons.fastfood,
        size: 35,
      ),
    );
  }
}

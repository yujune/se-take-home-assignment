import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';
import 'package:mcd_bot/modules/orders/ui/widget/oder_badge.dart';
import 'package:mcd_bot/util/enum/local_date_format.dart';
import 'package:mcd_bot/util/extension/context.dart';

class OrderListItem extends StatelessWidget {
  final Order order;
  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: OrderBadge(
        order: order,
      ),
      title: Text(
        order.id ?? '-',
        style: context.textTheme.bodySmall,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status: ${order.status?.name}",
            style: context.textTheme.labelSmall,
          ),
          Text(
            "Created Date: ${DateFormat(LocalDateFormat.dateWithTime.value).format(order.createdDate ?? DateTime.now())}",
            style: context.textTheme.labelSmall,
          )
        ],
      ),
      trailing: order.status?.isProcessing == true
          ? Lottie.asset("assets/lotties/cooking.json")
          : null,
    );
  }
}

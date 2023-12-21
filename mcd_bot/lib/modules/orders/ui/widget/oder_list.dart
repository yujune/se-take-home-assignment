import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';
import 'package:mcd_bot/modules/orders/ui/widget/order_list_item.dart';

class OrderList extends StatelessWidget {
  final List<Order> data;
  const OrderList({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Text(
          "No order",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
        ),
      );
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final order = data[index];
        return OrderListItem(
          key: ValueKey(order.id),
          order: order,
        );
      },
    );
  }
}

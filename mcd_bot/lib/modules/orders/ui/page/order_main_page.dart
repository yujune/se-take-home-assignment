import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/orders/constant.dart';
import 'package:mcd_bot/modules/orders/ui/page/completed_order_list_page.dart';
import 'package:mcd_bot/modules/orders/ui/page/pending_order_list_page.dart';

class OrderMainPage extends StatefulWidget {
  const OrderMainPage({super.key});

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: OrderTab.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order List'),
          bottom: TabBar(
            tabs: OrderTab.values
                .map(
                  (orderTab) => Tab(
                    text: orderTab.title,
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: OrderTab.values.map((orderTab) {
            if (orderTab.isPending) {
              return const PendingOrderListPage();
            } else if (orderTab.isCompleted) {
              return const CompletedOrderListPage();
            }
            return const SizedBox.shrink();
          }).toList(),
        ),
      ),
    );
  }
}

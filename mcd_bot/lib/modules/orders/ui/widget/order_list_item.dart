import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mcd_bot/modules/bots/view_model/bot_view_model.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';
import 'package:mcd_bot/modules/orders/ui/widget/oder_badge.dart';
import 'package:mcd_bot/util/enum/local_date_format.dart';
import 'package:mcd_bot/util/extension/context.dart';
import 'package:provider/provider.dart';

class OrderListItem extends StatefulWidget {
  final Order order;
  const OrderListItem({super.key, required this.order});

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  Stream<int>? _stream;

  Stream<int>? getBotOrderStream(BuildContext context) {
    final botViewModel = context.read<BotListViewModel>();
    final processingOrderMap = botViewModel.processingOrderMap;

    if (processingOrderMap.containsKey(widget.order.processingBy)) {
      return processingOrderMap[widget.order.processingBy]?.broadcastStream;
    }

    return null;
  }

  int getInitialRemainingTime() {
    final startProcessingDate = widget.order.processingDate;
    final currentDate = DateTime.now();

    final difference =
        currentDate.difference(startProcessingDate ?? currentDate);
    return 10 - difference.inSeconds;
  }

  @override
  void dispose() {
    _stream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: OrderBadge(
        order: widget.order,
      ),
      title: Text(
        widget.order.id ?? '-',
        style: context.textTheme.bodySmall,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status: ${widget.order.status?.name}",
            style: context.textTheme.labelSmall,
          ),
          Text(
            "Created Date: ${DateFormat(LocalDateFormat.dateWithTime.value).format(widget.order.createdDate ?? DateTime.now())}",
            style: context.textTheme.labelSmall,
          ),
          if (widget.order.status?.isProcessing == true)
            StreamBuilder<int>(
              initialData: getInitialRemainingTime(),
              stream: _stream ??= getBotOrderStream(context),
              builder: (_, snapshot) => snapshot.data == null
                  ? const SizedBox.shrink()
                  : Text('Time taken: ${snapshot.data}'),
            )
        ],
      ),
      trailing: widget.order.status?.isProcessing == true
          ? Lottie.asset("assets/lotties/cooking.json")
          : null,
    );
  }
}

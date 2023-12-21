import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';
import 'package:mcd_bot/modules/orders/ui/widget/oder_badge.dart';
import 'package:mcd_bot/util/enum/local_date_format.dart';
import 'package:mcd_bot/util/extension/context.dart';

class OrderListItem extends StatefulWidget {
  final Order order;
  const OrderListItem({super.key, required this.order});

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  Timer? _timer;

  num _timeTaken = 0;

  void setTimeTaken({required num value}) {
    setState(() {
      _timeTaken = value;
    });
  }

  num calculateRemainingTime() {
    final currentDateTime = DateTime.now();

    final processingDateTime = widget.order.processingDate ?? DateTime.now();

    final elapsedDateTime = currentDateTime.difference(processingDateTime);

    return elapsedDateTime.inSeconds;
  }

  void checkAndStopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void setupTimer() {
    checkAndStopTimer();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final value = calculateRemainingTime();
      setTimeTaken(value: value);
    });
  }

  @override
  void dispose() {
    checkAndStopTimer();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final value = calculateRemainingTime();
    setTimeTaken(value: value);
    setupTimer();
    super.didChangeDependencies();
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
            Text('Time taken: $_timeTaken'),
        ],
      ),
      trailing: widget.order.status?.isProcessing == true
          ? Lottie.asset("assets/lotties/cooking.json")
          : null,
    );
  }
}

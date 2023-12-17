import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mcd_bot/modules/bots/domain/entity/bot.dart';
import 'package:mcd_bot/util/enum/local_date_format.dart';
import 'package:mcd_bot/util/extension/context.dart';

class BotListItem extends StatelessWidget {
  final Bot bot;
  const BotListItem({
    super.key,
    required this.bot,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.android,
        size: 50,
      ),
      title: Text(
        bot.id ?? '-',
        style: context.textTheme.bodySmall,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status: ${bot.status?.name} ${bot.processingOrderId ?? ''}",
            style: context.textTheme.labelSmall,
          ),
          Text(
            "Created Date: ${DateFormat(LocalDateFormat.dateWithTime.value).format(bot.createdDate ?? DateTime.now())}",
            style: context.textTheme.labelSmall,
          )
        ],
      ),
      trailing: bot.status?.isProcessing == true
          ? Lottie.asset(LottieFiles.$41147_pizza_loading_icon)
          : null,
    );
  }
}

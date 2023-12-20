import 'package:mcd_bot/modules/bots/constant.dart';

class Bot {
  final String? id;
  final String? name;
  BotStatus? status;
  String? processingOrderId;
  final DateTime? createdDate;
  DateTime? processingDate;

  Bot({
    this.id,
    this.name,
    this.processingOrderId,
    this.createdDate,
    this.processingDate,
    this.status,
  });

  Bot.newBot()
      : this(
          id: "Bot-${DateTime.now().toIso8601String()}",
          createdDate: DateTime.now(),
          status: BotStatus.idle,
        );

  Bot.idle()
      : this(
          status: BotStatus.idle,
          processingDate: null,
          processingOrderId: null,
        );

  void setToProcessing({required String orderId}) {
    status = BotStatus.processing;
    processingOrderId = orderId;
    processingDate = DateTime.now();
  }

  void copyWith(Bot bot) {
    processingOrderId = bot.processingOrderId;
    processingDate = bot.processingDate;
    status = bot.status;
  }
}

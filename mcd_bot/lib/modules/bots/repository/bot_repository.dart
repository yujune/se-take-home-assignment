import 'package:mcd_bot/modules/bots/constant.dart';
import 'package:mcd_bot/modules/bots/domain/entity/bot.dart';

class BotRepository {
  List<Bot> getBots() {
    return [
      Bot(
        id: 'bot-1',
        name: 'Bot 1',
        status: BotStatus.idle,
        processingOrderId: null,
        createdDate: DateTime.now(),
        processingDate: null,
      ),
      Bot(
        id: 'bot-2',
        name: 'Bot 2',
        status: BotStatus.idle,
        processingOrderId: null,
        createdDate: DateTime.now(),
        processingDate: null,
      )
    ];
  }
}

import 'dart:async';
import 'dart:ui';

class BotOrder {
  final String botId;
  final String orderId;
  final VoidCallback onCooked;

  BotOrder({
    required this.botId,
    required this.orderId,
    required this.onCooked,
  });

  Timer? _timer;

  void cooks() {
    var requiredSeconds = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      requiredSeconds--;
      if (requiredSeconds <= 0) {
        print('Order $orderId done processed by $botId! Enjoy~');
        onCooked();
        timer.cancel();
      } else {
        print('$botId processing $orderId, $requiredSeconds left');
      }
    });
  }

  void cancelCook() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }
}

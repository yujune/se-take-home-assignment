import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/bots/constant.dart';
import 'package:mcd_bot/modules/bots/domain/entity/bot.dart';
import 'package:mcd_bot/modules/bots/domain/service/bot_order_service.dart';
import 'package:mcd_bot/modules/bots/repository/bot_repository.dart';
import 'package:mcd_bot/modules/orders/constant.dart';
import 'package:mcd_bot/modules/orders/ui/view_model/pending_order_list_view_model.dart';
import 'package:mcd_bot/util/enum/global.dart';
import 'package:collection/collection.dart';

class BotListViewModel extends ChangeNotifier {
  final BotRepository botRepository;
  final OrderListViewModel pendingOrderListViewModel;
  List<Bot> bots = [];
  ViewState viewState = ViewState.loading;

  Map<String, BotOrder> processingOrderMap = {};

  BotListViewModel({
    required this.botRepository,
    required this.pendingOrderListViewModel,
  }) {
    initData();
  }

  void setViewState(ViewState state) {
    viewState = state;
    notifyListeners();
  }

  Future<List<Bot>> getBots() async {
    bots = botRepository.getBots();
    notifyListeners();
    return bots;
  }

  Bot? getBotByIdAndStatus({
    required String botId,
    BotStatus? status = BotStatus.idle,
  }) =>
      bots.firstWhereOrNull(
        (bot) => bot.id == botId && bot.status == status,
      );

  Future<void> initData() async {
    await getBots();
    setViewState(ViewState.idle);
  }

  int getAvailableBotIndex() =>
      bots.indexWhere((bot) => bot.status == BotStatus.idle);

  bool hasAvailableBot() => getAvailableBotIndex() != -1;

  void _onOrderProcessed({required String orderId, required String startedBy}) {
    pendingOrderListViewModel.completeOrderById(
      orderId: orderId,
      completedBy: startedBy,
    );

    setBotToIdle(botId: startedBy);
  }

  void startBotOrder({required String orderId, required String startedBy}) {
    final newProcessingOrder = {
      startedBy: BotOrder(
        botId: startedBy,
        orderId: orderId,
        onCooked: () => _onOrderProcessed(
          orderId: orderId,
          startedBy: startedBy,
        ),
      )..cooks(),
    };
    processingOrderMap.addEntries(newProcessingOrder.entries);
  }

  void removeOrderTimerByBotId(String botId) {
    if (processingOrderMap.containsKey(botId)) {
      processingOrderMap[botId]!.cancelCook();
      processingOrderMap.remove(botId);
    }
  }

  String? checkAvailabilityAndProcessOrder({required String orderId}) {
    if (!hasAvailableBot()) {
      return null;
    }

    final botIndex = getAvailableBotIndex();
    final bot = bots[botIndex];

    bot.setToProcessing(orderId: orderId);

    startBotOrder(orderId: orderId, startedBy: bot.id ?? "");

    pendingOrderListViewModel.getOrderById(orderId: orderId);
    pendingOrderListViewModel.setOrderToProcessing(
      orderId: orderId,
      botId: bot.id ?? "",
    );

    return bot.id;
  }

  void removeBot() {
    if (bots.isEmpty) {
      return;
    }

    final firstBot = bots.first;

    if (firstBot.status?.isProcessing == true) {
      removeOrderTimerByBotId(firstBot.id ?? "");
      final order = pendingOrderListViewModel.getOrderByIdAndStatus(
        orderId: firstBot.processingOrderId ?? "",
        status: OrderStatus.processing,
      );

      if (order != null) {
        print("order ${order.toString()} found");
        pendingOrderListViewModel.setOrderToIdle(orderId: order.id ?? "");
        checkAvailabilityAndProcessOrder(
            orderId: firstBot.processingOrderId ?? "");
      }
    }
    bots.removeAt(0);
    notifyListeners();
  }

  Bot addBot() {
    final bot = Bot.newBot();
    bots.add(bot);
    notifyListeners();
    return bot;
  }

  void updateBotById({required String botId, required Bot request}) {}

  void setBotToIdle({required String botId}) {
    final bot = getBotByIdAndStatus(botId: botId, status: BotStatus.processing);
    bot?.copyWith(
      Bot.idle(),
    );
    notifyListeners();

    checkIdleOrderAndProcessIt(botId: botId);
  }

  void checkIdleOrderAndProcessIt({required String botId}) {
    final order =
        pendingOrderListViewModel.checkIdleOrderAndUpdateStatus(botId: botId);

    if (order != null) {
      checkAvailabilityAndProcessOrder(orderId: order.id ?? "");
    }
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:mcd_bot/modules/orders/constant.dart';
import 'package:mcd_bot/modules/orders/domain/entity/order.dart';

class OrderListViewModel extends ChangeNotifier {
  List<Order> orderList = [];
  List<Order> pendingOrderList = [];
  List<Order> completedOrderList = [];

  void updateOrder({required String orderId, required Order request}) {
    final order = getOrderById(
      orderId: orderId,
    );
    order?.copyWith(request);
    priotizeVipOrder();
  }

  void addOrder(Order order) {
    orderList.add(order);
    priotizeVipOrder();
    notifyListeners();
  }

  Order? getOrderById({
    required String orderId,
  }) =>
      orderList.firstWhereOrNull(
        (order) => order.id == orderId,
      );

  Order? getOrderByIdAndStatus({
    required String orderId,
    OrderStatus? status = OrderStatus.idle,
  }) =>
      orderList.firstWhereOrNull(
        (order) => order.id == orderId && order.status == status,
      );

  List<Order> getCompletedOrderList() =>
      orderList.where((order) => order.status?.isCompleted == true).toList();

  List<Order> getPendingVipOrderList() => orderList
      .where((order) =>
          order.type == OrderType.vip && (order.status?.isCompleted != true))
      .toList();

  List<Order> getPendingNormalOrderList() => orderList
      .where((order) =>
          order.type == OrderType.normal && (order.status?.isCompleted != true))
      .toList();

  void updateCompletedOrderList() {
    completedOrderList = [...getCompletedOrderList()];
    completedOrderList.sortBy(
      (order) => order.createdDate ?? DateTime.now(),
    );
  }

  void priotizeVipOrder() {
    final vipOrderList = getPendingVipOrderList();
    final normalOrderList = getPendingNormalOrderList();

    pendingOrderList = [...vipOrderList, ...normalOrderList];
  }

  int getIdleOrderIndex() =>
      pendingOrderList.indexWhere((order) => order.status == OrderStatus.idle);

  bool hasIdleOrder() => getIdleOrderIndex() != -1;

  Order? checkIdleOrderAndUpdateStatus({required String botId}) {
    if (!hasIdleOrder()) {
      return null;
    }

    final idleOrderIndex = getIdleOrderIndex();
    final idleOrder = pendingOrderList[idleOrderIndex];
    setOrderToProcessing(orderId: idleOrder.id ?? "", botId: botId);
    notifyListeners();

    return idleOrder;
  }

  void setOrderToIdle({
    required String orderId,
  }) {
    updateOrder(
      orderId: orderId,
      request: Order.idle(),
    );
    notifyListeners();
  }

  void setOrderToProcessing({
    required String orderId,
    required String botId,
  }) {
    updateOrder(
      orderId: orderId,
      request: Order.processing(
        botId: botId,
      ),
    );
    notifyListeners();
  }

  void completeOrderById({
    required String orderId,
    required String completedBy,
  }) {
    updateOrder(
      orderId: orderId,
      request: Order.completed(
        botId: completedBy,
      ),
    );
    updateCompletedOrderList();
    notifyListeners();
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mcd_bot/modules/orders/constant.dart';
import 'package:mcd_bot/modules/orders/domain/entity/product.dart';

class Order {
  final String? id;
  final String? title;
  final List<Product>? products;
  final DateTime? createdDate;
  DateTime? processingDate;
  DateTime? completedDate;
  OrderStatus? status;
  final double? totalPrice;
  final OrderType? type;
  String? processingBy;
  String? completedBy;

  Order({
    this.id,
    this.title,
    this.products,
    this.createdDate,
    this.processingDate,
    this.completedDate,
    this.totalPrice,
    this.type,
    this.processingBy,
    this.completedBy,
    this.status,
  });

  Order.newOrder({OrderType type = OrderType.normal})
      : this(
          id: "Order-${DateTime.now().toIso8601String()}",
          createdDate: DateTime.now(),
          status: OrderStatus.idle,
          type: type,
        );

  Order.processing({required String botId})
      : this(
          processingBy: botId,
          processingDate: DateTime.now(),
          status: OrderStatus.processing,
        );

  Order.completed({required String botId})
      : this(
          completedBy: botId,
          completedDate: DateTime.now(),
          processingBy: null,
          processingDate: null,
          status: OrderStatus.completed,
        );

  Order.idle()
      : this(
          completedBy: null,
          completedDate: null,
          processingBy: null,
          processingDate: null,
          status: OrderStatus.idle,
        );

  void setStatus(OrderStatus status) {
    status = status;
  }

  void setProcessingBy(String? botId) {
    processingBy = botId;
  }

  void setCompletedBy(String? botId) {
    completedBy = botId;
  }

  void setCompletedDate(DateTime date) {
    completedDate = date;
  }

  void copyWith(Order order) {
    processingDate = order.processingDate;
    completedDate = order.completedDate;
    processingBy = order.processingBy;
    completedBy = order.completedBy;
    status = order.status;
  }
}

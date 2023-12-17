import 'package:flutter/material.dart';

enum BottomTab {
  orders(
    title: "Order",
    icon: Icon(Icons.shopping_cart),
  ),
  bots(
    title: "Bots",
    icon: Icon(Icons.android),
  );

  const BottomTab({required this.title, required this.icon});

  final String title;
  final Icon icon;
}

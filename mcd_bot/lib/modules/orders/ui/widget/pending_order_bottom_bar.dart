import 'package:flutter/material.dart';
import 'package:mcd_bot/util/constant/color.dart';

class PendingOrderBottomBar extends StatelessWidget {
  final VoidCallback onAddVipOrderPressed;
  final VoidCallback onAddNormalOrderPressed;
  const PendingOrderBottomBar(
      {super.key,
      required this.onAddVipOrderPressed,
      required this.onAddNormalOrderPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColor.secondary),
              onPressed: onAddVipOrderPressed,
              child: const Text(
                'Add VIP order',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: onAddNormalOrderPressed,
              child: const Text(
                'Add Normal order',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

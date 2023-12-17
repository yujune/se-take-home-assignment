import 'package:flutter/material.dart';

class BotBottomBar extends StatelessWidget {
  final VoidCallback onRemovePressed;
  final VoidCallback onAddPressed;
  const BotBottomBar(
      {super.key, required this.onRemovePressed, required this.onAddPressed});

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
              onPressed: onAddPressed,
              child: const Text('Add'),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: onRemovePressed,
              child: const Text('Remove'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/bots/ui/page/bot_list_page.dart';
import 'package:mcd_bot/modules/home/constant.dart';
import 'package:mcd_bot/modules/home/view_model/home_bottom_navigator_view_model.dart';
import 'package:mcd_bot/modules/orders/ui/page/order_main_page.dart';
import 'package:mcd_bot/util/extension/context.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigator extends StatefulWidget {
  const HomeBottomNavigator({super.key});

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<HomeBottomNavigator> {
  void onBottomTabPressed({required BuildContext context, required int index}) {
    context.read<HomeBottomNavigatorViewModel>().setCurrentIndex(index);
  }

  Widget _buildScreen(int currentIndex) {
    if (currentIndex == BottomTab.orders.index) {
      return const OrderMainPage();
    } else if (currentIndex == BottomTab.bots.index) {
      return const BotListPage();
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBottomNavigatorViewModel(),
      builder: (context, child) {
        final currentIndex = context.select(
          (HomeBottomNavigatorViewModel homeBottomNavigatorViewModel) =>
              homeBottomNavigatorViewModel.currentIndex,
        );
        return Scaffold(
          body: Center(
            child: _buildScreen(currentIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: context.colorScheme.primary,
            unselectedItemColor: Colors.black38,
            unselectedLabelStyle: const TextStyle(color: Colors.black38),
            selectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(color: Colors.white),
            currentIndex: currentIndex,
            onTap: (index) =>
                onBottomTabPressed(context: context, index: index),
            items: BottomTab.values
                .map(
                  (bottomTab) => BottomNavigationBarItem(
                    icon: bottomTab.icon,
                    label: bottomTab.title,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

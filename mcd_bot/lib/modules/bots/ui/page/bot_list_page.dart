import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/bots/ui/widget/bot_bottom_bar.dart';
import 'package:mcd_bot/modules/bots/ui/widget/bot_list_item.dart';
import 'package:mcd_bot/modules/bots/view_model/bot_view_model.dart';
import 'package:mcd_bot/util/enum/global.dart';
import 'package:provider/provider.dart';

class BotListPage extends StatelessWidget {
  const BotListPage({super.key});

  void _onRemoveBotPressed(BuildContext context) {
    final botListViewModel = context.read<BotListViewModel>();
    botListViewModel.removeBot();
  }

  void _onAddBotPressed(BuildContext context) {
    final botListViewModel = context.read<BotListViewModel>();
    final bot = botListViewModel.addBot();
    botListViewModel.checkIdleOrderAndProcessIt(botId: bot.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BotListViewModel>(
      builder: (context, botListViewModel, child) {
        if (botListViewModel.viewState == ViewState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Bots"),
          ),
          body: ListView.separated(
            itemCount: botListViewModel.bots.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final bot = botListViewModel.bots[index];
              return BotListItem(bot: bot);
            },
          ),
          bottomNavigationBar: BotBottomBar(
            onRemovePressed: () {
              _onRemoveBotPressed(context);
            },
            onAddPressed: () {
              _onAddBotPressed(context);
            },
          ),
        );
      },
    );
  }
}

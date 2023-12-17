import 'package:mcd_bot/modules/bots/repository/bot_repository.dart';
import 'package:mcd_bot/modules/bots/view_model/bot_view_model.dart';
import 'package:mcd_bot/modules/orders/ui/view_model/pending_order_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  final pendingOrderListViewModel = OrderListViewModel();

  List<SingleChildWidget> get providers => [
        ChangeNotifierProvider.value(value: pendingOrderListViewModel),
        ChangeNotifierProvider(
          create: (context) {
            final botRepository = BotRepository();
            return BotListViewModel(
              botRepository: botRepository,
              pendingOrderListViewModel: pendingOrderListViewModel,
            );
          },
        ),
      ];
}

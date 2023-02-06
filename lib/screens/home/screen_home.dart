import 'package:flutter/material.dart';
import 'package:money_manager/database/category/category_db.dart';
import 'package:money_manager/database/transaction/transaction_db.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/show_screen.dart';
import 'package:money_manager/screens/home/widgets/bottom_nav.dart';
import 'package:money_manager/screens/home/widgets/colors.dart';

import 'package:money_manager/screens/settings/screen_settings.dart';
import 'package:money_manager/screens/statitics/screen_statistics.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
    const ShowScreen(),
    const ScreenCategory(),
    const ScreenStatitics(),
    const ScreenSettings()
  ];

  @override
  Widget build(BuildContext context) {
    TransactionsDB.instance.refresh();
    CategoryDB.instance.refreshUI();

    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      backgroundColor: ThemeColor.themeColors,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, _) {
            return _pages[updateIndex];
          },
        ),
      ),
    );
  }
}

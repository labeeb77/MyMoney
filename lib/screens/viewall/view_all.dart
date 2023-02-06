import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/screens/transactoins/filters/date_filter.dart';
import 'package:money_manager/screens/transactoins/filters/overview_filter.dart';
import 'package:money_manager/screens/viewall/search_all.dart';

import '../../database/transaction/transaction_db.dart';
import '../home/widgets/colors.dart';
import '../transactoins/transaction_list.dart';

ValueNotifier categoryNotifier = ValueNotifier('All');
ValueNotifier dateNotifier = ValueNotifier('All');

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {

    TransactionsDB.instance.refresh();
    return Scaffold(
      resizeToAvoidBottomInset :false,
      appBar: AppBar(
        title:  Text(
          'All Transactions', style: GoogleFonts.quicksand(color: const Color.fromARGB(255, 255, 255, 255))
        ),
        backgroundColor: ThemeColor.themeColors,
        actions: const [
          //.............Overviewfilter...........//

          OverViewFilter(),

          //.............Datefilter................//

          DateFilter()
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: const [
            SearchAll(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: MyTransactions(),
            ),
          ],
        ),
      ),
    );
  }
}

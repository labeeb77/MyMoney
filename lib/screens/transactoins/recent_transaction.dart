import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/database/transaction/transaction_db.dart';
import 'package:money_manager/screens/transactoins/slidable_widget.dart';

import '../../models/transaction/transaction_model.dart';
import '../home/widgets/colors.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionsDB.instance.transactionListNotfier,
      builder:
          (BuildContext context, List<TransactionModel> newList, Widget? _) {
        return newList.isEmpty
            ? Center(
                child: Text('No transactions found',
                    style:
                        GoogleFonts.quicksand(color: ThemeColor.themeColors)),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final trValue = newList[index];
                      return SlidableWidget(
                        trValue: trValue,
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: newList.length > 3 ? 3 : newList.length),
              );
      },
    );
  }
}

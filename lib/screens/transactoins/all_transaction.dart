import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/database/transaction/transaction_db.dart';
import 'package:money_manager/screens/transactoins/slidable_widget.dart';

import '../../models/transaction/transaction_model.dart';
import '../home/widgets/colors.dart';

ValueNotifier<List<TransactionModel>> overViewNotifier =
    ValueNotifier(TransactionsDB.instance.transactionListNotfier.value);

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  void initState() {
    TransactionsDB.instance.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: overViewNotifier,
      builder:(context, newList, Widget? _){
        return ValueListenableBuilder(
        valueListenable: TransactionsDB.instance.transactionListNotfier,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          return newList.isEmpty
              ?  Text(
                'No transactions found',style: GoogleFonts.quicksand(color: ThemeColor.themeColors),)
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
                      itemCount: newList.length),
                );
        },
      );
      },
       
    );
  }
}

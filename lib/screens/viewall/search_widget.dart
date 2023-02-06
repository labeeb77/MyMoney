import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/database/category/category_db.dart';
import 'package:money_manager/database/transaction/transaction_db.dart';
import 'package:money_manager/screens/transactoins/slidable_widget.dart';
import '../../models/transaction/transaction_model.dart';

class SearchTransaction extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    TransactionsDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionsDB.instance.transactionListNotfier,
      builder:
          (BuildContext context, List<TransactionModel> newList, Widget? _) {
        List<TransactionModel> transaction = [];
        transaction = newList
            .where(
              (element) => element.category.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();

        return transaction.isEmpty
            ? const Center(
                child: Text('no data found'),
              )
            : ListView.separated(
                itemBuilder: ((context, index) {
                  return SlidableWidget(
                      trValue: transaction[index], index: index);
                }),
                itemCount: newList.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 2,
                  );
                },
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionsDB.instance.transactionListNotfier,
      builder:
          (BuildContext context, List<TransactionModel> newList, Widget? _) {
        List<TransactionModel> transaction = [];
        transaction = newList
            .where(
              (element) => element.category.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();

        return transaction.isEmpty
            ? const Center(
                child: Text('no data found'),
              )
            : ListView.separated(
                itemBuilder: ((context, index) {
                  return SlidableWidget(
                      trValue: transaction[index], index: index);
                }),
                itemCount: newList.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 2,
                  );
                },
              );
      },
    );
  }

  String parseDate(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }
}

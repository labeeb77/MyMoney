import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/database/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screens/category/category_popup.dart';
import 'package:money_manager/screens/category/expense_category.dart';
import 'package:money_manager/screens/category/income_category.dart';

import '../home/widgets/colors.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    CategoryDB().refreshUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Category',
          style: GoogleFonts.quicksand(
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 167, 49, 3),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 25),
            child: TabBar(
              labelColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedLabelColor: const Color.fromARGB(255, 107, 4, 4),
              controller: tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ThemeColor.themeColors,
              ),
              tabs: const [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSE',
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: tabController,
                physics: const ScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: const [
                  IncomeCategory(),
                  ExpenseCategory(),
                ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColor.themeColors,
        onPressed: () {
          log(tabController.index.toString());
          categoryAddPopup(
              context,
              false,
              tabController.index == 0
                  ? CategoryType.income
                  : CategoryType.expense);
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 245, 239, 239),
        ),
      ),
    );
  }
}

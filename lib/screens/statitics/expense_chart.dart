import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/screens/home/widgets/colors.dart';
import 'package:money_manager/screens/statitics/overview_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({super.key});

  @override
  State<ExpenseChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<ExpenseChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
_tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: overviewChartList,
         builder: (context, chartData, child) {
          var expenseData = chartData
          .where((element) => element.category.type == CategoryType.expense).toList();
          return expenseData.isEmpty
          ?  Center(child: Text('No data',style: GoogleFonts.quicksand(color: ThemeColor.themeColors),),)
          :Padding(
            padding: const EdgeInsets.all(25.0),
            child: SfCircularChart(
              backgroundColor: Colors.white,
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.scroll,
                alignment: ChartAlignment.center
              ),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                   PieSeries<TransactionModel,String>(
                  
                  dataSource: expenseData,
                  xValueMapper: (TransactionModel data, _) => 
                  data.category.name,
                  yValueMapper: (TransactionModel data, _) => 
                  data.amount,
                  enableTooltip: true,
                  dataLabelSettings: const DataLabelSettings(isVisible: true)
                )
              ],
            ),
          );
           
         },),
    );
  }
}
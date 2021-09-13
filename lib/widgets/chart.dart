import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  late final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double totalSpending() {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      num amount = item['amount'] as num;
      print('amount = $amount');
      print('totalSum = ${sum + amount}');
      return (sum + amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map(
            (data) {
              return Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data["day"] as String,
                  spendingAmount: data['amount'] as double,
                  spendingPercentageOfTotal: totalSpending() == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending(),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPercentageOfTotal});

  late final String label;
  late final double spendingAmount;
  late final double spendingPercentageOfTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            height: 5.0,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Container(
            height: 60.0,
            width: 10.0,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(label),
        ),
      ],
    );
  }
}

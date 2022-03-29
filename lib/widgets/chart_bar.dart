import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('.\$${spendingAmount.toStringAsFixed(0)}')
            ),
        ),
        SizedBox(
          height: 7,
        ),
        SizedBox(
          child: Container(
            height: 80,
            width: 15,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(0),
                      ),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(label),
      ],
    );
  }
}

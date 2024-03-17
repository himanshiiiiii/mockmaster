import 'package:flutter/material.dart';
import 'package:mock_master/utils/colors.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double value;
  final int maxValue;

  CustomLinearProgressIndicator({required this.value, this.maxValue = 10});

  @override
  Widget build(BuildContext context) {
    double progress = (value / maxValue).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${(value * 100/maxValue).toDouble()}%',
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
              ),
              Text("/",style: TextStyle(fontSize: 14),),
              Text(
                '${(maxValue * 100 / maxValue).toInt()}%',
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2,color: Colors.black38),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

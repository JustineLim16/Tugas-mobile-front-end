import 'package:chocobi/screens/button_nav.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:chocobi/data/money.dart';

class CircularIndicatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalIncome = 0;
    double totalExpense = 0;
    Map<String, double> descriptionTotals = {};

    // Calculate totals
    for (var item in all) {
      double price = item['price'] ?? 0.0;
      if (item['category'] == 'income') {
        totalIncome += price;
      } else {
        totalExpense += price;
      }

      if (descriptionTotals.containsKey(item['description'])) {
        descriptionTotals[item['description']] = descriptionTotals[item['description']]! + price;
      } else {
        descriptionTotals[item['description']] = price;
      }
    }

    double totalAmount = totalIncome + totalExpense;

    List<double> segmentLengths = descriptionTotals.values
        .map((amount) => amount / totalAmount)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 80, 156),
        title: Text(
          "Financial Report",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCircularProgressIndicator(
            goal: totalAmount,
            segmentLengths: segmentLengths,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Expense'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Income'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  final double goal;
  final List<double> segmentLengths;

  CustomCircularProgressIndicator({required this.goal, required this.segmentLengths});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CustomPaint(
            painter: CircularProgressPainter(segmentLengths),
          ),
        ),
        Text(
          goal.toStringAsFixed(0),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final List<double> segmentLengths;

  CircularProgressPainter(this.segmentLengths);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 20.0;
    double radius = (size.width / 2) - strokeWidth / 2;
    double startAngle = -pi / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint segmentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    List<Color> colors = [Colors.orange, Colors.purple, Colors.red];

    for (int i = 0; i < segmentLengths.length; i++) {
      double sweepAngle = segmentLengths[i] * 2 * pi;
      segmentPaint.color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        segmentPaint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.segmentLengths != segmentLengths;
  }
}

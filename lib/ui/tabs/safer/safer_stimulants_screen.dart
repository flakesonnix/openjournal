import 'package:flutter/material.dart';

class SaferStimulantsScreen extends StatelessWidget {
  const SaferStimulantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safer stimulant use')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Consider how long you want to stay awake. Don't suppress your need for sleep.\n\n"
              "Drink enough non-alcoholic drinks (3 - 5 dl per hour) and take breaks in the fresh air.\n\n"
              "Eat healthy before and after consumption and do not consume on an empty stomach.\n\n"
              "People with psychological disorders, pre-existing cardiovascular conditions, asthma, liver and kidney disorders or diabetes, hyperthyroidism and pregnant women are particulary discouraged from taking stimulants.\n\n"
              "Take vitamin C and D and minerals (iron, calcium and magnesium) with frequent use.\n\n"
              "It is better not to wear headgear (danger of overheating).",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

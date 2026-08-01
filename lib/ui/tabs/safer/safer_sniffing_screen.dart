import 'package:flutter/material.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';

class SaferSniffingScreen extends StatelessWidget {
  const SaferSniffingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safer sniffing')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "The nose is a sensitive organ: fine hairs protect the nasal mucous membranes from external impurities (dust, pollen, etc.). If a foreign substance is now ingested through the nose, this and its mucous membranes are subjected to above-average stress.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            _buildSection(
              context,
              "Hygiene first",
              "Pay attention to hygiene in general, wash your hands before and after consumption and always use a clean, dry and smooth surface (mirror or similar). Do not snort on/from dirty surfaces such as toilets.",
            ),
            _buildSection(
              context,
              "Mine is mine",
              "Always use your personal sniffing utensil. Do not share utensils as this is unhygienic and can transmit diseases. Banknotes are not suitable as they are often carriers of bacteria and viruses.",
            ),
            _buildSection(
              context,
              "Powder is not just powder",
              "Crush the powder as finely as possible and dose low! The active ingredient content can vary greatly from time to time, even if the substance comes from the same source.",
            ),
            _buildSection(
              context,
              "Take care of your nose",
              "Blow your nose before sniffling and for about 10 minutes afterwards! You should rinse your nose after consumption or at the latest the next day and care for it with a moisturising/fatty cream.",
            ),
            _buildSection(
              context,
              "Nasal rinsing",
              "To do this, you need 2.5 grams of nasal rinsing salt and dissolve it in 2.5 decilitres of lukewarm water. You can also buy ready-made sea salt nasal sprays at the pharmacy/drugstore.",
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return CardWithTitle(
      title: title,
      child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }
}

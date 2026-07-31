import 'package:flutter/material.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';

class SaferHallucinogensScreen extends StatelessWidget {
  const SaferHallucinogensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safer hallucinogens')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "The information below is exclusively tailored for the use and experimentation with hallucinogens such as psychedelics, dissociatives, and deliriants.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            _buildSection(
              context,
              "Setting",
              "Choosing a suitable place to experience the effects of a hallucinogen is extremely important and plays a major role in determining the outcome of the experience. The ideal place for an inexperienced user is a familiar, safe, indoor environment over which they have full control and is devoid of factors that can negatively influence one's mental state. In order to prepare a proper setting for hallucinogens, it is advised to take the following steps:\n\n"
              "• Ensure that one is completely free of responsibilities for the duration of the experience, and ideally the day after.\n\n"
              "• Avoid people who are not directly participating in the experience.\n\n"
              "• Avoid unfamiliar, loud, cluttered, and/or public environments.\n\n"
              "• Avoid sources of anything that can generate \"bad vibes.\"",
            ),
            _buildSection(
              context,
              "Set (state of mind)",
              "The user's set or state of mind in plays a major role in determining the outcome of a trip. Hallucinogens amplify one's current state of mind, mood and outlook: a positive mindset will likely become more positive and a negative one will become even more negative.\n\n"
              "Those with preexisting mental conditions (especially individuals with psychotic illnesses like schizophrenia) should avoid hallucinogens due to the way they can strongly amplify one's underlying mental and emotional state.\n\n"
              "A common piece of advice while tripping is to \"let go\" and allow the effects of the substance to take charge. One should take the metaphorical passenger seat and forgo trying to control or suppress any part of the experience.",
            ),
            _buildSection(
              context,
              "Bodily state",
              "The user's current bodily condition is just as important as one's mood and mindset when going into a trip. If one feels tired, sick or injured, these sensations will manifest as amplified versions of the same conditions.\n\n"
              "Instead of tripping while stressed, tired, sick or injured, one should wait for a more suitable opportunity.",
            ),
            _buildSection(
              context,
              "Trip sitters",
              "When using hallucinogens, a trip sitter is strongly recommended to be present, particularly if one is inexperienced with the substance. It is the trip sitter's responsibility to assist the individual or group by maintaining a calm and grounded frame of mind.\n\n"
              "A good trip sitter must fulfill a number of requirements. In addition to being a generally responsible adult, they should ideally be sober and able to relate to the group members' situation.",
            ),
            _buildSection(
              context,
              "Aborting trips",
              "Hallucinogens have the potential to become overwhelming and push the user into a paranoid or dreadful mood.\n\n"
              "If one decides to terminate the trip, benzodiazepines and other sedatives such as some antipsychotics can be considered analogous to an \"eject button\".",
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

import 'package:flutter/material.dart';

class SelfDiagnoseHealthPage extends StatefulWidget {
  const SelfDiagnoseHealthPage({super.key});

  @override
  _SelfDiagnoseHealthPageState createState() => _SelfDiagnoseHealthPageState();
}

class _SelfDiagnoseHealthPageState extends State<SelfDiagnoseHealthPage> {
  // 🔹 Käyttäjän vastaukset
  String age = "";
  String height = "";
  String weight = "";
  String gender = "";
  String sleepQuality = "";
  String exerciseLevel = "";
  String dietQuality = "";
  String waterIntake = "";
  String screenTime = "";
  String fatigue = "";
  String stress = "";
  String caffeine = "";
  String headaches = "";
  String smoking = "";
  String alcohol = "";
  String chronicDiseases = "";
  String medications = "";

  void showResults() {
    List<String> recommendations = [];

    if (sleepQuality == "Alle 6 tuntia") {
      recommendations.add(
        "Pyri nukkumaan vähintään 7–9 tuntia yössä paremman palautumisen takaamiseksi.",
      );
    }
    if (exerciseLevel == "En lainkaan") {
      recommendations.add(
        "Säännöllinen liikunta parantaa terveyttäsi merkittävästi. Kokeile lisätä kevyt liikunta päivittäiseen rutiiniisi.",
      );
    }
    if (dietQuality == "Epäterveellisesti") {
      recommendations.add(
        "Terveellinen ruokavalio on avain hyvinvointiin. Lisää ruokavalioosi enemmän vihanneksia ja täysjyväviljoja.",
      );
    }
    if (waterIntake == "Alle 1 litra") {
      recommendations.add(
        "Juotko tarpeeksi vettä? Suositus on vähintään 1,5–2 litraa päivässä.",
      );
    }
    if (screenTime == "Yli 8 tuntia") {
      recommendations.add(
        "Pidä taukoja ruutuajasta vähintään 5–10 minuutin välein.",
      );
    }
    if (fatigue == "Kyllä, usein") {
      recommendations.add(
        "Huomaatko usein väsymystä? Kiinnitä huomiota uneen, ruokavalioon ja stressinhallintaan.",
      );
    }
    if (stress == "Kyllä, usein") {
      recommendations.add(
        "Kokeile rentoutusharjoituksia, meditaatiota tai liikuntaa stressitasojen hallintaan.",
      );
    }
    if (caffeine == "Paljon") {
      recommendations.add(
        "Vähennä kofeiinin määrää, jos huomaat univaikeuksia tai levottomuutta.",
      );
    }
    if (headaches == "Kyllä, usein") {
      recommendations.add(
        "Tarkista ergonomia, nesteytys ja ruutuaika, jos kärsit usein päänsärystä.",
      );
    }
    if (smoking == "Kyllä") {
      recommendations.add(
        "Tupakan vähentäminen tai lopettaminen parantaa terveyttäsi huomattavasti.",
      );
    }
    if (alcohol == "Paljon") {
      recommendations.add(
        "Runsas alkoholinkäyttö voi vaikuttaa unen laatuun ja terveyteen. Kohtuullinen käyttö on suositeltavaa.",
      );
    }
    if (chronicDiseases == "Kyllä") {
      recommendations.add(
        "Jos sinulla on pitkäaikaissairauksia, varmista, että seuraat tilannettasi lääkärin kanssa.",
      );
    }
    if (medications == "Kyllä") {
      recommendations.add(
        "Varmista, että lääkityksesi on ajantasainen ja sopii nykyiseen terveydentilaasi.",
      );
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Terveyskartoituksen tulokset'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    recommendations.isNotEmpty
                        ? recommendations
                            .map(
                              (rec) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text("• $rec"),
                              ),
                            )
                            .toList()
                        : [
                          Text(
                            "Terveytesi vaikuttaa olevan hyvällä tasolla! Jatka samaan malliin.",
                          ),
                        ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Lopeta kysely'),
              ),
            ],
          ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRadioButtons(
    String label,
    List<String> options,
    String groupValue,
    Function(String) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            children:
                options
                    .map(
                      (option) => RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: groupValue,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              onChanged(value);
                            });
                          }
                        },
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terveyskysely")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildTextField(
                  "Ikä (vuosia)",
                  (value) => setState(() => age = value),
                ),
                _buildTextField(
                  "Pituus (cm)",
                  (value) => setState(() => height = value),
                ),
                _buildTextField(
                  "Paino (kg)",
                  (value) => setState(() => weight = value),
                ),

                _buildRadioButtons(
                  "Sukupuoli",
                  ["Mies", "Nainen", "Muu"],
                  gender,
                  (value) => setState(() => gender = value),
                ),
                _buildRadioButtons(
                  "Kuinka monta tuntia nukut yössä?",
                  ["Alle 6 tuntia", "6–8 tuntia", "Yli 8 tuntia"],
                  sleepQuality,
                  (value) => setState(() => sleepQuality = value),
                ),
                _buildRadioButtons(
                  "Kuinka usein harrastat liikuntaa?",
                  ["En lainkaan", "1–2 kertaa viikossa", "3+ kertaa viikossa"],
                  exerciseLevel,
                  (value) => setState(() => exerciseLevel = value),
                ),
                _buildRadioButtons(
                  "Miten arvioisit ruokavaliosi?",
                  ["Epäterveellisesti", "Kohtuullisesti", "Terveellisesti"],
                  dietQuality,
                  (value) => setState(() => dietQuality = value),
                ),
                _buildRadioButtons(
                  "Kuinka paljon vettä juot päivittäin?",
                  ["Alle 1 litra", "1–2 litraa", "Yli 2 litraa"],
                  waterIntake,
                  (value) => setState(() => waterIntake = value),
                ),
                _buildRadioButtons(
                  "Kuinka monta tuntia vietät ruudun ääressä päivittäin?",
                  ["Alle 4 tuntia", "4–8 tuntia", "Yli 8 tuntia"],
                  screenTime,
                  (value) => setState(() => screenTime = value),
                ),
                _buildRadioButtons(
                  "Tunnetko olosi usein väsyneeksi tai uupuneeksi?",
                  ["Ei", "Joskus", "Kyllä, usein"],
                  fatigue,
                  (value) => setState(() => fatigue = value),
                ),
                _buildRadioButtons(
                  "Koetko stressiä päivittäin?",
                  ["Ei", "Joskus", "Kyllä, usein"],
                  stress,
                  (value) => setState(() => stress = value),
                ),
                _buildRadioButtons(
                  "Käytätkö kofeiinia päivittäin?",
                  ["Ei", "Vähän", "Paljon"],
                  caffeine,
                  (value) => setState(() => caffeine = value),
                ),
                _buildRadioButtons(
                  "Onko sinulla usein päänsärkyä?",
                  ["Ei", "Joskus", "Kyllä, usein"],
                  headaches,
                  (value) => setState(() => headaches = value),
                ),
                _buildRadioButtons(
                  "Tupakoitko tai käytätkö nikotiinituotteita?",
                  ["Ei", "Kyllä"],
                  smoking,
                  (value) => setState(() => smoking = value),
                ),
                _buildRadioButtons(
                  "Käytätkö alkoholia?",
                  ["En lainkaan", "Harvoin", "Paljon"],
                  alcohol,
                  (value) => setState(() => alcohol = value),
                ),
                _buildRadioButtons(
                  "Onko sinulla pitkäaikaissairauksia?",
                  ["Ei", "Kyllä"],
                  chronicDiseases,
                  (value) => setState(() => chronicDiseases = value),
                ),
                _buildRadioButtons(
                  "Käytätkö säännöllistä lääkitystä?",
                  ["Ei", "Kyllä"],
                  medications,
                  (value) => setState(() => medications = value),
                ),

                // 🔹 "Näytä tulokset" -nappi
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: showResults,
                  child: Text("Näytä tulokset"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

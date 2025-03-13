import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: SelfDiagnoseFatiguePage()));
}

class SelfDiagnoseFatiguePage extends StatefulWidget {
  const SelfDiagnoseFatiguePage({super.key});

  @override
  _SelfDiagnoseFatiguePageState createState() =>
      _SelfDiagnoseFatiguePageState();
}

class _SelfDiagnoseFatiguePageState extends State<SelfDiagnoseFatiguePage> {
  List<int> selectedAnswers = List.filled(9, -1);
  int totalScore = 0;

  final List<String> questionTexts = [
    'Miten hyvin jaksat keskittyä arkipäivän asioihin viimeisten kahden viikon aikana?',
    'Miten hyvin pystyt muistamaan arjessa tarvittavat asiat?',
    'Tunnetko itsesi ruumiillisesti tavallista väsyneemmäksi arkipäivän puuhien tai fyysisen ponnistelun jälkeen?',
    'Miten sitkeästi olet viime viikkoina jaksanut toimittaa arkipäivän tehtäviäsi, ja millaisiksi koet henkiset voimavarasi?',
    'Miten hyvin ja nopeasti palaudut rasituksesta henkisesti ja ruumiillisesti?',
    'Miten hyvää unesi on ollut ja/tai oletko tuntenut itsesi levänneeksi viimeisten kahden viikon aikana?',
    'Tuntuuko sinusta, että jokin tai jotkin aisteistasi ovat tulleet tavallista herkemmiksi?',
    'Miten reagoit vaatimuksiin, joita sinulle asetetaan arkipäivässäsi?',
    'Miten ärtyneeksi tai vihaiseksi tunnet itsesi sisäisesti?',
  ];

  final List<List<String>> options = [
    [
      'Minun ei ole vaikea keskittyä (0 p.)',
      'Minun on joskus vaikea keskittyä (1 p.)',
      'Minun on usein vaikea keskittyä (2 p.)',
      'En jaksa keskittyä mihinkään (3 p.)',
      'En pysty keskittymään oikein mihinkään (4 p.)',
      'Minun on todella vaikea keskittyä (5 p.)',
      'En jaksa keskittyä mihinkään (6 p.)',
    ],
    [
      'Muistan vaivatta nimet, päivämäärät ja asiat jotka minun on tehtävä (0 p.)',
      'Saatan unohtaa vähemmän tärkeitä asioita, mutta jos kokoan itseni, muistan suurimman osan (1 p.)',
      'Unohdan usein tapaamisia tai hyvienkin tuttujen nimiä (2 p.)',
      'Unohdan päivittäin tärkeitäkin asioita tai asioita, jotka minun olisi pitänyt tehdä (3 p.)',
      'Muistan vähemmän kuin normaalisti, mutta en muista kaikki (4 p.)',
      'En muista juuri mitään tärkeää (5 p.)',
      'Unohdan päivittäin kaiken tärkeän (6 p.)',
    ],
    [
      'Oloni tuntuu normaalilta, arkipäivän liikkuminen ja urheiluharrastukset sujuvat kuten tavallisesti (0 p.)',
      'Ruumiilliset ponnistukset väsyttävät minua enemmän kuin yleensä, mutta liikun silti tavalliseen tapaan (1 p.)',
      'Ruumiillinen ponnistelu tuntuu vaikealta. Jaksan niin kauan kuin liikun normaaliin tahtiin, mutta jos lisään vauhtia, hengästyn ja minua alkaa heikottaa (2 p.)',
      'Tunnen oloni todella heikoksi, enkä jaksa kävellä lyhyitäkään matkoja (3 p.)',
      'En jaksa kävellä lyhyitäkään matkoja tai tunnen itseni heikoksi lähes koko ajan (4 p.)',
      'En jaksa tehdä mitään (5 p.)',
      'En jaksa liikuttaa itseäni ollenkaan (6 p.)',
    ],
    [
      'Minulla on energiaa saman verran kuin tavallisesti (0 p.)',
      'Selviän arkipäivän tehtävistäni, mutta se vie tavallista enemmän voimia ja väsyn tavallista nopeammin. Tarvitsen taukoja useammin kuin yleensä (1 p.)',
      'Väsyn epätavallisen paljon, kun yritän selvitä tavallisesta arjestani, ja ihmisten kanssa oleminen tuntuu rasittavalta (2 p.)',
      'En jaksa tehdä juuri mitään (3 p.)',
      'Minusta tuntuu, että olen todella väsyneempi kuin yleensä (4 p.)',
      'En pysty tekemään mitään (5 p.)',
      'Olen jatkuvasti väsynyt eikä mikään motivoi (6 p.)',
    ],
    [
      'Minun ei tarvitse levätä päivällä (0 p.)',
      'Väsyn päivän aikana, mutta tarvitsen vain pienen tauon ja jaksan taas (1 p.)',
      'Väsyn päivän aikana ja tarvitsen pitkiä taukoja, että tuntisin oloni pirteämmäksi (2 p.)',
      'Väsyn niin paljon, että ei ole merkitystä kuinka paljon lepään (3 p.)',
      'Minulla on vaikeuksia palautua edes pitkistä lepohetkistä (4 p.)',
      'Palaan takaisin normaaliksi vain silloin, jos saan nukkua (5 p.)',
      'Ei ole mitään väliä, kuinka paljon lepään (6 p.)',
    ],
    [
      'Nukun hyvin ja tarpeeksi pitkään (0 p.)',
      'Joskus nukun levottomammin tai minun on vaikea nukahtaa uudelleen, jos herään yöllä (1 p.)',
      'Nukun usein levottomasti, herään yöllä enkä saa unta takaisin (2 p.)',
      'En tunne itseäni levänneeksi yöllisten heräämisten takia (3 p.)',
      'Nukun levottomasti ja herään joka yö, mutta ei ole merkitystä (4 p.)',
      'En tunne itseäni virkeäksi koskaan (5 p.)',
      'Nukun todella huonosti, herään usein enkä saa unta enää takaisin (6 p.)',
    ],
    [
      'Minusta aistini eivät ole tavallista herkemmät (0 p.)',
      'Äänet, valot tai muut aistiärsykkeet voivat välillä tuntua epämukavilta (1 p.)',
      'Koen äänet, valot tai muut aistiärsykkeet usein häiritsevinä (2 p.)',
      'Äänet, valot tai muut aistiärsykkeet häiritsevät minua niin paljon, että vetäydyn pois (3 p.)',
      'Koen aistiärsykkeet niin voimakkaina, että en pysty keskittymään niihin (4 p.)',
      'En kestä lainkaan valoja, ääniä tai muita ärsykkeitä (5 p.)',
      'Aistiherkkyys on niin voimakasta, että ei voi olla missään paikassa (6 p.)',
    ],
    [
      'Teen sen mitä minun tarvitsee tehdä, enkä koe sitä erityisen vaativaksi tai hankalaksi (0 p.)',
      'Arkipäivän tilanteet, jotka olen aikaisemmin hallinnut ilman erityisiä ongelmia, tuntuvat välillä hankalilta (1 p.)',
      'Useimmat asiat tuntuvat todella vaativilta (2 p.)',
      'Useimmat asiat tuntuvat mahdottomilta, en jaksa tehdä juuri mitään (3 p.)',
      'Kaikki tuntuu vaikealta ja vaativalta (4 p.)',
      'En jaksa tehdä mitään tai kykenemätön tekemään asioita (5 p.)',
      'En pysty tekemään mitään (6 p.)',
    ],
    [
      'En tunne itseäni erityisen ärtyneeksi (0 p.)',
      'Olen tavallista kärsimättömämpi, mutta se menee myös nopeasti ohi (1 p.)',
      'Suutun tai provosoidun helpommin (2 p.)',
      'Joskus menetän malttini tavalla, joka ei ole minulle normaalia (3 p.)',
      'Usein olen sisäisesti suorastaan raivoissani ja joudun pinnistämään tosissani, että hallitsen itseni (4 p.)',
      'Tunnen jatkuvaa raivoa tai vihaa (5 p.)',
      'Olen jatkuvasti ärtynyt ja raivoissani (6 p.)',
    ],
  ];

  void showInstructions() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Ohjeet'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lue ohjeet tarkasti, kyselyyn vastaamisesta ja pisteiden laskemisesta.',
                  ),
                  SizedBox(height: 10),
                  Text('Vastaaminen:'),
                  Text(
                    'Jokaisessa kysymyksessä on seitsemän vastausvaihtoehdon asteikko, joista voit valita vaihtoehdon, joka kuvaa parhaiten oloasi viimeisten KAHDEN VIIKON aikana.',
                  ),
                  SizedBox(height: 10),
                  Text('Tulosten laskeminen:'),
                  Text(
                    'Jos pisteiden kokonaismäärä on 19 tai enemmän, sinun kannattaa kiinnittää erityistä huomiota rasituksen ja palautumisen tasapainoon.',
                  ),
                  Text(
                    'Pisteitten maksimimäärä on 54. Mitä korkeampi pistemäärä on, sitä enemmän kärsii pitkäkestoiselle ylikuormitukselle tyypillisistä oireista ja ongelmista.',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startSurvey();
                },
                child: Text('Aloita kysely'),
              ),
            ],
          ),
    );
  }

  void startSurvey() {
    setState(() {
      totalScore = 0;
    });
  }

  void calculateTotalScore() {
    totalScore = selectedAnswers.reduce((value, element) => value + element);
  }

  void showResults() {
    calculateTotalScore();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Kyselyn tulos'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pistemäärä: $totalScore'),
                SizedBox(height: 10),
                Text(
                  totalScore <= 19
                      ? 'Pisteet 0–19: Vähäinen uupuneisuus\nTämä pistemäärä viittaa tilanteeseen, jossa uupuneisuus on vähäistä. Ajoittainen uupumuksen tunne on luonnollinen ja normaali osa elämää.'
                      : 'Pisteet 20–54: Merkittävä uupuneisuus\nTämä pistemäärä viittaa tilanteeseen, jossa uupuneisuus on merkittävää. Kannattaa kiinnittää erityistä huomiota rasituksen ja palautumisen tasapainoon.',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);

                  setState(() {
                    selectedAnswers = List.filled(9, -1);
                  });
                },
                child: Text('Lopeta kysely'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Itsediagnoosi')),
      body: Column(
        children: [
          ElevatedButton(onPressed: showInstructions, child: Text('Ohjeet')),
          Expanded(
            child: ListView.builder(
              itemCount: questionTexts.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(questionTexts[index]),
                    ...List.generate(options[index].length, (optionIndex) {
                      return RadioListTile<int>(
                        value: optionIndex,
                        groupValue: selectedAnswers[index],
                        title: Text(options[index][optionIndex]),
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              selectedAnswers[index] = value;
                            });
                          }
                        },
                      );
                    }),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(onPressed: showResults, child: Text('Näytä tulokset')),
        ],
      ),
    );
  }
}

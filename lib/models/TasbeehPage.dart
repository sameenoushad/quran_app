import 'package:flutter/material.dart';

class TasbeehPage extends StatefulWidget {
  const TasbeehPage({super.key});

  @override
  State<TasbeehPage> createState() => _TasbeehPageState();
}

class _TasbeehPageState extends State<TasbeehPage> {
  final List<Map<String, String>> phrases = [
    {'label': 'Subhan Allah', 'arabic': 'سُبْحَانَ ٱللَّٰهِ'},
    {'label': 'Alhamdulillah', 'arabic': 'ٱلْـحَمْدُ لِلَّٰهِ'},
    {'label': 'Allahu Akbar', 'arabic': 'ٱللَّٰهُ أَكْبَرُ'},
    {'label': 'La ilaha illallah', 'arabic': 'لَا إِلَٰهَ إِلَّا ٱللَّٰهُ'},
    {'label': 'Astaghfirullah', 'arabic': 'أَسْتَغْفِرُ ٱللَّٰهَ'},
    {'label': 'La hawla wala quwwata', 'arabic': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِٱللَّٰهِ'},
    {'label': 'SubhanAllahi wa bihamdihi', 'arabic': 'سُبْحَانَ ٱللَّٰهِ وَبِحَمْدِهِ'},
    {'label': 'SubhanAllahi Azeem', 'arabic': 'سُبْحَانَ ٱللَّٰهِ ٱلْعَظِيمِ'},
    {'label': 'Hasbunallahu wa ni\'mal wakeel', 'arabic': 'حَسْبُنَا ٱللَّٰهُ وَنِعْمَ ٱلْوَكِيلُ'},
    {'label': 'Bismillah', 'arabic': 'بِسْمِ ٱللَّٰهِ'},
    {'label': 'Ya Hayyu Ya Qayyum', 'arabic': 'يَا حَيُّ يَا قَيُّومُ'},
    {'label': 'Rabbi zidni ilma', 'arabic': 'رَبِّ زِدْنِي عِلْمًا'},
    {'label': 'Allahumma ajirni min an-naar', 'arabic': 'ٱللَّهُمَّ أَجِرْنِي مِنَ ٱلنَّارِ'},
   {
  'label': 'Durood Ibrahimi',
  'arabic': 'اللَّهُمَّ صَلِّ عَلَىٰ مُحَمَّدٍ وَعَلَىٰ آلِ مُحَمَّدٍ، كَمَا صَلَّيْتَ عَلَىٰ إِبْرَاهِيمَ وَعَلَىٰ آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ. اللَّهُمَّ بَارِكْ عَلَىٰ مُحَمَّدٍ وَعَلَىٰ آلِ مُحَمَّدٍ، كَمَا بَارَكْتَ عَلَىٰ إِبْرَاهِيمَ وَعَلَىٰ آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ'
},
{
  'label': 'Durood e Nariya',
  'arabic': 'اللَّهُمَّ صَلِّ صَلَاةً كَامِلَةً وَسَلِّمْ سَلَامًا تَامًّا عَلَىٰ سَيِّدِنَا مُحَمَّدٍ، الَّذِي تَنْحَلُّ بِهِ الْعُقَدُ، وَتَنْفَرِجُ بِهِ الْكُرَبُ، وَتُقْضَىٰ بِهِ الْحَوَائِجُ، وَتُنَالُ بِهِ الرَّغَائِبُ، وَحُسْنُ الْخَوَاتِيمِ، وَيُسْتَسْقَىٰ الْغَمَامُ بِوَجْهِهِ الْكَرِيمِ، وَعَلَىٰ آلِهِ وَصَحْبِهِ فِي كُلِّ لَمْحَةٍ وَنَفَسٍ بِعَدَدِ كُلِّ مَعْلُومٍ لَكَ'
},
{
  'label': 'Durood e Taj',
  'arabic': 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَىٰ سَيِّدِنَا مُحَمَّدٍ، صَاحِبِ التَّاجِ وَالْمِعْرَاجِ وَالْبُرَاقِ وَالْعَلَمِ، دَافِعِ الْبَلَاءِ وَالْوَبَاءِ وَالْقَحْطِ وَالْمَرَضِ وَالْأَلَمِ، اسْمُهُ مَكْتُوبٌ مَرْفُوعٌ مَشْفُوعٌ مَنْقُوشٌ فِي اللَّوْحِ وَالْقَلَمِ، سَيِّدِ الْعَرَبِ وَالْعَجَمِ، جِسْمُهُ مُقَدَّسٌ مُعَطَّرٌ مُنَوَّرٌ فِي الْبَيْتِ وَالْحَرَمِ، شَمْسِ الضُّحَىٰ، بَدْرِ الدُّجَىٰ، صَدْرِ الْعُلَىٰ، نُورِ الْهُدَىٰ، كَهْفِ الْوَرَىٰ، مِسْبَاحِ الظُّلَمِ، جَمِيلِ الشِّيَمِ، شَفِيعِ الْأُمَمِ، صَاحِبِ الْجُودِ وَالْكَرَمِ، وَاللَّهُ عَاصِمُهُ وَجِبْرِيلُ خَادِمُهُ، وَالْبُرَاقُ مَرْكَبُهُ، وَالْمِعْرَاجُ سَفَرُهُ، وَسِدْرَةُ الْمُنْتَهَىٰ مَقَامُهُ، وَقَابَ قَوْسَيْنِ مَطْلُوبُهُ، وَالْمَطْلُوبُ مَقْصُودُهُ، وَالْمَقْصُودُ مَوْجُودٌ، سَيِّدِ الْمُرْسَلِينَ، خَاتَمِ النَّبِيِّينَ، شَفِيعِ الْمُذْنِبِينَ، أَنِيسِ الْغَرِيبِينَ، رَحْمَةٍ لِلْعَالَمِينَ، رَاحَةِ الْعَاشِقِينَ، مُرَادِ الْمُشْتَاقِينَ، شَمْسِ الْعَارِفِينَ، سِرَاجِ السَّالِكِينَ، مِصْبَاحِ الْمُقَرَّبِينَ، مُحِبِّ الْفُقَرَاءِ وَالْمَسَاكِينِ، سَيِّدِ الثَّقَلَيْنِ، نَبِيِّ الْحَرَمَيْنِ، إِمَامِ الْقِبْلَتَيْنِ، وَسِيلَتِنَا فِي الدَّارَيْنِ، صَاحِبِ قَابَ قَوْسَيْنِ، مَحْبُوبِ رَبِّ الْمَشْرِقَيْنِ وَرَبِّ الْمَغْرِبَيْنِ، جَدِّ الْحَسَنِ وَالْحُسَيْنِ، مَوْلَانَا وَمَوْلَى الثَّقَلَيْنِ، أَبِي الْقَاسِمِ، مُحَمَّدِ بْنِ عَبْدِ اللَّهِ، نُورٍ مِنْ نُورِ اللَّهِ، يَا أَيُّهَا الْمُشْتَاقُونَ بِنُورِ جَمَالِهِ، صَلُّوا عَلَيْهِ وَآلِهِ وَأَصْحَابِهِ وَسَلِّمُوا تَسْلِيمًا'
},
{
  'label': 'Short Durood',
  'arabic': 'صَلَّى ٱللَّٰهُ عَلَىٰ مُحَمَّدٍ'
},
{
  'label': 'Durood e Tunjina',
  'arabic': 'اللَّهُمَّ صَلِّ عَلَىٰ سَيِّدِنَا مُحَمَّدٍ صَلَاةً تُنْجِينَا بِهَا مِنْ جَمِيعِ الْأَهْوَالِ وَالْآفَاتِ، وَتَقْضِي لَنَا بِهَا جَمِيعَ الْحَاجَاتِ، وَتُطَهِّرُنَا بِهَا مِنْ جَمِيعِ السَّيِّئَاتِ، وَتَرْفَعُنَا بِهَا عِنْدَكَ أَعْلَى الدَّرَجَاتِ، وَتُبَلِّغُنَا بِهَا أَقْصَى الْغَايَاتِ مِنْ جَمِيعِ الْخَيْرَاتِ فِي الْحَيَاةِ وَبَعْدَ الْمَمَاتِ، إِنَّهُ سَمِيعٌ قَرِيبٌ مُجِيبُ الدَّعَوَاتِ'
},
{
  'label': 'Durood e Ghausia',
  'arabic': 'اللَّهُمَّ صَلِّ عَلَىٰ سَيِّدِنَا مُحَمَّدٍ، طِبِّ الْقُلُوبِ وَدَوَائِهَا، وَعَافِيَةِ الْأَبْدَانِ وَشِفَائِهَا، وَنُورِ الْأَبْصَارِ وَضِيَائِهَا، وَعَلَىٰ آلِهِ وَصَحْبِهِ وَسَلِّمْ'
}

  ];

  int counter = 0;
  int currentIndex = 0;

  void _increment() => setState(() => counter++);
  void _reset() => setState(() => counter = 0);
  void _nextPhrase() => setState(() {
        currentIndex = (currentIndex + 1) % phrases.length;
        counter = 0;
      });

  @override
  Widget build(BuildContext context) {
    final currentPhrase = phrases[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🧮 Tasbeeh & Durood'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 146, 222, 215), // 🔹 Background teal 400
        child: Stack(
          children: [
            // 🌄 Background Image
            Positioned.fill(
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  'assets/images/mosque 1-1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 🌟 Foreground Content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentPhrase['label']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentPhrase['arabic']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Text(
                      '$counter',
                      style: TextStyle(fontSize: 40, color: Colors.teal.shade400),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _increment,
                    icon: const Icon(Icons.add_circle),
                    label: const Text("Count"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal.shade700,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: _nextPhrase,
                        icon: const Icon(Icons.swap_horiz),
                        label: const Text('Next'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

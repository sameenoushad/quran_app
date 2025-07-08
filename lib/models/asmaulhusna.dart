import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Asmaulhusna extends StatelessWidget {
  Asmaulhusna({super.key});

 final List<Map<String, String>> namesOfAllah = const [
  {"arabic": "ٱللَّٰه", "english": "Allah"},
  {"arabic": "ٱلرَّحْمَٰن", "english": "The Most Gracious"},
  {"arabic": "ٱلرَّحِيم", "english": "The Most Merciful"},
  {"arabic": "ٱلْمَلِك", "english": "The King"},
  {"arabic": "ٱلْقُدُّوس", "english": "The Most Sacred"},
  {"arabic": "ٱلسَّلَام", "english": "The Source of Peace"},
  {"arabic": "ٱلْمُؤْمِن", "english": "The Guardian of Faith"},
  {"arabic": "ٱلْمُهَيْمِن", "english": "The Protector"},
  {"arabic": "ٱلْعَزِيز", "english": "The Almighty"},
  {"arabic": "ٱلْجَبَّار", "english": "The Compeller"},
  {"arabic": "ٱلْمُتَكَبِّر", "english": "The Supreme"},
  {"arabic": "ٱلْخَالِق", "english": "The Creator"},
  {"arabic": "ٱلْبَارِئ", "english": "The Evolver"},
  {"arabic": "ٱلْمُصَوِّر", "english": "The Fashioner"},
  {"arabic": "ٱلْغَفَّار", "english": "The Constant Forgiver"},
  {"arabic": "ٱلْقَهَّار", "english": "The All-Subduer"},
  {"arabic": "ٱلْوَهَّاب", "english": "The Supreme Bestower"},
  {"arabic": "ٱلرَّزَّاق", "english": "The Provider"},
  {"arabic": "ٱلْفَتَّاح", "english": "The Supreme Opener"},
  {"arabic": "ٱلْعَلِيم", "english": "The All-Knowing"},
  {"arabic": "ٱلْقَابِض", "english": "The Withholder"},
  {"arabic": "ٱلْبَاسِط", "english": "The Extender"},
  {"arabic": "ٱلْخَافِض", "english": "The Abaser"},
  {"arabic": "ٱلرَّافِع", "english": "The Exalter"},
  {"arabic": "ٱلْمُعِزُّ", "english": "The Honourer"},
  {"arabic": "ٱلْمُذِلُّ", "english": "The Dishonourer"},
  {"arabic": "ٱلسَّمِيع", "english": "The All-Hearing"},
  {"arabic": "ٱلْبَصِير", "english": "The All-Seeing"},
  {"arabic": "ٱلْحَكَم", "english": "The Impartial Judge"},
  {"arabic": "ٱلْعَدْل", "english": "The Utterly Just"},
  {"arabic": "ٱلْلَّطِيف", "english": "The Subtly Kind"},
  {"arabic": "ٱلْخَبِير", "english": "The All-Aware"},
  {"arabic": "ٱلْحَلِيم", "english": "The Most Forbearing"},
  {"arabic": "ٱلْعَظِيم", "english": "The Magnificent"},
  {"arabic": "ٱلْغَفُور", "english": "The Great Forgiver"},
  {"arabic": "ٱلْشَّكُور", "english": "The Most Appreciative"},
  {"arabic": "ٱلْعَلِيِّ", "english": "The Most High"},
  {"arabic": "ٱلْكَبِير", "english": "The Most Great"},
  {"arabic": "ٱلْحَفِيظ", "english": "The Preserver"},
  {"arabic": "ٱلْمُقِيت", "english": "The Sustainer"},
  {"arabic": "ٱلْحسِيب", "english": "The Reckoner"},
  {"arabic": "ٱلْجَلِيل", "english": "The Majestic"},
  {"arabic": "ٱلْكَرِيم", "english": "The Most Generous"},
  {"arabic": "ٱلْرَّقِيب", "english": "The Watchful"},
  {"arabic": "ٱلْمُجِيب", "english": "The Responsive One"},
  {"arabic": "ٱلْوَاسِع", "english": "The All-Encompassing"},
  {"arabic": "ٱلْحَكِيم", "english": "The All-Wise"},
  {"arabic": "ٱلْوَدُود", "english": "The Most Loving"},
  {"arabic": "ٱلْمَجِيد", "english": "The Glorious"},
  {"arabic": "ٱلْبَاعِث", "english": "The Infuser of New Life"},
  {"arabic": "ٱلْشَّهِيد", "english": "The All-and-Ever Witnessing"},
  {"arabic": "ٱلْحَق", "english": "The Absolute Truth"},
  {"arabic": "ٱلْوَكِيل", "english": "The Trustee"},
  {"arabic": "ٱلْقَوِيُ", "english": "The All-Strong"},
  {"arabic": "ٱلْمَتِين", "english": "The Firm One"},
  {"arabic": "ٱلْوَلِيُ", "english": "The Sole Provider"},
  {"arabic": "ٱلْحَمِيد", "english": "The Praiseworthy"},
  {"arabic": "ٱلْمُحْصِي", "english": "The All-Enumerating"},
  {"arabic": "ٱلْمُبْدِئ", "english": "The Originator"},
  {"arabic": "ٱلْمُعِيد", "english": "The Restorer"},
  {"arabic": "ٱلْمُحْيِي", "english": "The Giver of Life"},
  {"arabic": "ٱلْمُمِيت", "english": "The Creator of Death"},
  {"arabic": "ٱلْحَيُّ", "english": "The Ever-Living"},
  {"arabic": "ٱلْقَيُّوم", "english": "The Sustainer"},
  {"arabic": "ٱلْوَاجِد", "english": "The Perceiver"},
  {"arabic": "ٱلْمَاجِد", "english": "The Glorious, the Most Honorable"},
  {"arabic": "ٱلْواحِد", "english": "The One"},
  {"arabic": "ٱلْأَحَد", "english": "The Indivisible, the Absolute"},
  {"arabic": "ٱلصَّمَد", "english": "The Self-Sufficient, The Impregnable"},
  {"arabic": "ٱلْقَادِر", "english": "The Omnipotent"},
  {"arabic": "ٱلْمُقْتَدِر", "english": "The Creator of All Power"},
  {"arabic": "ٱلْمُقَدِّم", "english": "The Expediter"},
  {"arabic": "ٱلْمُؤَخِّر", "english": "The Delayer"},
  {"arabic": "ٱلأوَّل", "english": "The First"},
  {"arabic": "ٱلْآخِر", "english": "The Last"},
  {"arabic": "ٱلْظَّاهِر", "english": "The Manifest"},
  {"arabic": "ٱلْبَاطِن", "english": "The Hidden One, Knower of the Hidden"},
  {"arabic": "ٱلْوَالِي", "english": "The Sole Governor"},
  {"arabic": "ٱلْمُتَعَالِي", "english": "The Self Exalted"},
  {"arabic": "ٱلْبَرُّ", "english": "The Source of All Goodness"},
  {"arabic": "ٱلْتَّوَاب", "english": "The Ever-Accepter of Repentance"},
  {"arabic": "ٱلْمُنْتَقِم", "english": "The Avenger"},
  {"arabic": "ٱلْعَفُو", "english": "The Supreme Pardoner"},
  {"arabic": "ٱلْرَّؤُف", "english": "The Most Kind"},
  {"arabic": "مَالِكُ ٱلْمُلْك", "english": "Master of the Kingdom, Owner of the Dominion"},
  {"arabic": "ذُوالْجَلاَلِ وَٱلْإِكْرَام", "english": "Lord of Glory and Honour, Lord of Majesty and Generosity"},
  {"arabic": "ٱلْمُقْسِط", "english": "The Just One"},
  {"arabic": "ٱلْجَامِع", "english": "The Gatherer, the Uniter"},
  {"arabic": "ٱلْغَنيُ", "english": "The Self-Sufficient, the Wealthy"},
  {"arabic": "ٱلْمُغْنِي", "english": "The Enricher"},
  {"arabic": "ٱلْمَانِع", "english": "The Withholder"},
  {"arabic": "ٱلضَّارَ", "english": "Distresser"},
  {"arabic": "ٱلنَّافِع", "english": "The Propitious, the Benefactor"},
  {"arabic": "ٱلْنُّور", "english": "The Light, the Illuminator"},
  {"arabic": "ٱلْهَادِي", "english": "The Guide"},
  {"arabic": "ٱلْبَدِيع", "english": "The Incomparable Originator"},
  {"arabic": "ٱلْبَاقِي", "english": "The Everlasting"},
  {"arabic": "ٱلْوَارِث", "english": "The Inheritor, the Heir"},
  {"arabic": "ٱلرَّشِيد", "english": "The Guide, Infallible Teacher, and Knower"},
  {"arabic": "ٱلصَّبُور", "english": "The Most Patient"},
];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.teal,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/kaaba.png', // Make sure this image exists
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 8),
            Text(
              "ٱللهُ ٱلْأَسْمَاءُ ٱلْحُسْنَى",
              style: GoogleFonts.amiri(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey.shade900]
                : [Colors.teal.shade50, Colors.teal.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
          itemCount: namesOfAllah.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 100,
          ),
          itemBuilder: (context, index) {
            final item = namesOfAllah[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.teal.shade100,
                      blurRadius: 6,
                      offset: const Offset(2, 3),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['arabic']!,
                    style: GoogleFonts.amiriQuran(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.teal.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['english']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.teal.shade700,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

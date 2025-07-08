import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NamesOfProphet extends StatelessWidget {
   NamesOfProphet({super.key});

final List<Map<String, String>> namesOfProphet = [
  {"arabic": "مُحَمَّد", "english": "Muhammad"},
  {"arabic": "أَحْمَد", "english": "Ahmad"},
  {"arabic": "الحامد", "english": "The Praiser"},
  {"arabic": "الماحي", "english": "The Eraser (of disbelief)"},
  {"arabic": "العاقب", "english": "The Last (no prophet after him)"},
  {"arabic": "الحاشر", "english": "The Gatherer"},
  {"arabic": "نبي الرحمة", "english": "The Prophet of Mercy"},
  {"arabic": "نبي التوبة", "english": "The Prophet of Repentance"},
  {"arabic": "نبي الملحمة", "english": "The Prophet of Battle"},
  {"arabic": "عبد الله", "english": "Servant of Allah"},
  {"arabic": "نبي الله", "english": "Prophet of Allah"},
  {"arabic": "رسول الله", "english": "Messenger of Allah"},
  {"arabic": "الرسول", "english": "The Messenger"},
  {"arabic": "النبي الأمي", "english": "The Unlettered Prophet"},
  {"arabic": "طـه", "english": "Taha"},
  {"arabic": "يـس", "english": "Ya Seen"},
  {"arabic": "المزمّل", "english": "The Enshrouded One"},
  {"arabic": "المدّثّر", "english": "The Cloaked One"},
  {"arabic": "الصادق الأمين", "english": "The Truthful, The Trustworthy"},
  {"arabic": "الشفيع", "english": "The Intercessor"},
  {"arabic": "المشفع", "english": "The One Granted Intercession"},
  {"arabic": "المختار", "english": "The Chosen One"},
  {"arabic": "المصطفى", "english": "The Selected One"},
  {"arabic": "خاتم النبيين", "english": "Seal of the Prophets"},
  {"arabic": "سيد المرسلين", "english": "Master of the Messengers"},
  {"arabic": "سيد ولد آدم", "english": "Master of the Children of Adam"},
  {"arabic": "رحمة للعالمين", "english": "Mercy to the Worlds"},
  {"arabic": "النذير", "english": "The Warner"},
  {"arabic": "السراج المنير", "english": "Illuminating Lamp"},
  {"arabic": "البشير", "english": "Bringer of Good News"},
  {"arabic": "المنذر", "english": "The Warner"},
  {"arabic": "الضحوك القتال", "english": "The Smiling Fighter"},
  {"arabic": "الشهيد", "english": "The Witness"},
  {"arabic": "المبشر", "english": "The Bearer of Glad Tidings"},
  {"arabic": "الداعي إلى الله", "english": "Caller to Allah"},
  {"arabic": "السيد", "english": "The Master"},
  {"arabic": "الصفي", "english": "The Chosen"},
  {"arabic": "الحبيب", "english": "The Beloved"},
  {"arabic": "الولي", "english": "The Guardian"},
  {"arabic": "الهادي", "english": "The Guide"},
  {"arabic": "الرؤوف", "english": "The Kind"},
  {"arabic": "الرحيم", "english": "The Merciful"},
  {"arabic": "النور", "english": "The Light"},
  {"arabic": "المنير", "english": "The Illuminator"},
  {"arabic": "أمين الوحي", "english": "Trustworthy of the Revelation"},
  {"arabic": "زكي", "english": "Pure"},
  {"arabic": "طه الأمين", "english": "Taha the Trustworthy"},
  {"arabic": "صاحب الشفاعة", "english": "Holder of Intercession"},
  {"arabic": "صاحب المقام المحمود", "english": "Holder of the Praised Station"},
  {"arabic": "صاحب اللواء المعقود", "english": "Bearer of the Banner"},
  {"arabic": "المؤيد", "english": "The Supported"},
  {"arabic": "المنصور", "english": "The Victorious"},
  {"arabic": "المنقذ", "english": "The Savior"},
  {"arabic": "الكريم", "english": "The Generous"},
  {"arabic": "الزين", "english": "The Handsome"},
  {"arabic": "الجميل", "english": "The Beautiful"},
  {"arabic": "الحق", "english": "The Truth"},
  {"arabic": "الرسالة", "english": "The Message"},
  {"arabic": "أول المسلمين", "english": "The First of the Muslims"},
  {"arabic": "المتوكل", "english": "The Reliant"},
  {"arabic": "الخاتم", "english": "The Seal"},
  {"arabic": "الموقر", "english": "The Revered"},
  {"arabic": "المبجل", "english": "The Honored"},
  {"arabic": "المرسل", "english": "The Sent One"},
  {"arabic": "المأمون", "english": "The Trusted"},
  {"arabic": "المنجي", "english": "The Deliverer"},
  {"arabic": "البار", "english": "The Dutiful"},
  {"arabic": "الزاهد", "english": "The Ascetic"},
  {"arabic": "العابد", "english": "The Worshipper"},
  {"arabic": "الذاكر", "english": "The One Who Remembers"},
  {"arabic": "الشاكر", "english": "The Thankful"},
  {"arabic": "الراكع", "english": "The One Who Bows"},
  {"arabic": "الساجد", "english": "The One Who Prostrates"},
  {"arabic": "الطاهر", "english": "The Pure"},
  {"arabic": "العفيف", "english": "The Chaste"},
  {"arabic": "المؤمن", "english": "The Believer"},
  {"arabic": "المبتهل", "english": "The Devout"},
  {"arabic": "الوفي", "english": "The Loyal"},
  {"arabic": "الصادق", "english": "The Truthful"},
  {"arabic": "الأمين", "english": "The Trustworthy"},
  {"arabic": "الحليم", "english": "The Forbearing"},
  {"arabic": "الرزين", "english": "The Calm"},
  {"arabic": "السمح", "english": "The Generous"},
  {"arabic": "المدني", "english": "The Madinan"},
  {"arabic": "المكي", "english": "The Makkan"},
  {"arabic": "المؤيد بجبرائيل", "english": "Supported by Jibreel"},
  {"arabic": "المعصوم", "english": "The Infallible"},
  {"arabic": "المهدي", "english": "The Guided"},
  {"arabic": "البدر", "english": "The Full Moon"},
  {"arabic": "الشمس", "english": "The Sun"},
  {"arabic": "السيف", "english": "The Sword"},
  {"arabic": "الدر", "english": "The Pearl"},
  {"arabic": "الهاشم", "english": "The Hashemite"},
  {"arabic": "القريشي", "english": "The Quraishi"},
  {"arabic": "العربي", "english": "The Arab"},
  {"arabic": "المعلم", "english": "The Teacher"},
  {"arabic": "الناصح", "english": "The Advisor"},
  {"arabic": "المذكر", "english": "The Reminder"},
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
        'assets/images/madina.png', // Make sure this path is correct
        height: 32,
        width: 32,
      ),
      const SizedBox(width: 8),
      Text(
        "أسماء النبي ﷺ",
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
          itemCount: namesOfProphet.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 100, // allows taller cards
          ),
          itemBuilder: (context, index) {
            final item = namesOfProphet[index];
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

import 'package:flutter/material.dart';

class EndTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Spacer for top padding
            const SizedBox(height: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main title
                Text(
                  "أحسنت لقد أنهيت مرحلة الصوت بنجاح",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  """الآن، سننتقل إلى المرحلة الأخيرة اختبار الفيديو، حيث ستقلد تعابير وجه لشخصية في مشهد تمثيل
اقرأ النص بتركيز، وتحضر للتعبير عن ( الدهشة، الصدمة، والغضب)
""",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Icon in the middle
            Container(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/images/directorlogo.png",
                fit: BoxFit.fill,
              ),
            ),
            // Start button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/videotest");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3B008D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "ابدأ الإختبار",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

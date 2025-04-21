import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // الخلفية الداكنة
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'تحليل الأداء',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // مؤشر الأداء العام
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: 0.65, // 65%
                            strokeWidth: 8,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.purple),
                            backgroundColor: Colors.grey.shade800,
                          ),
                        ),
                        const Text(
                          '65%',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'هو مؤشر الأداء العام لديك',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // البطاقات الأربع
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                padding: const EdgeInsets.all(16),
                shrinkWrap:
                    true, // يجعل GridView قابلة للسكرول داخل SingleChildScrollView
                physics:
                    const NeverScrollableScrollPhysics(), // تعطيل سكرول GridView فقط
                children: const [
                  PerformanceCard(
                    title: 'سمة الفرح',
                    progress: 0.7,
                    color: Colors.blue,
                  ),
                  PerformanceCard(
                    title: 'سمة الغضب',
                    progress: 0.5,
                    color: Colors.red,
                  ),
                  PerformanceCard(
                    title: 'تعابير الوجهه',
                    progress: 0.6,
                    color: Colors.green,
                  ),
                  PerformanceCard(
                    title: 'سمة الحزن',
                    progress: 0.9,
                    color: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // الشبكة الخاصة بالشخصيات
              CharacterGrid(),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'حاب تعرف ابعادك وتبدع في اداءك؟',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/actlog");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'سجل الدخول',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PerformanceCard extends StatelessWidget {
  final String title;
  final double progress;
  final Color color;

  const PerformanceCard({
    Key? key,
    required this.title,
    required this.progress,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // خلفية البطاقة
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  color: color,
                  backgroundColor: Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(progress * 100).toInt()}%', // النص الرقمي
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // إضافة وظيفة لتحسين الأداء
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'تحسين أدائك',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterGrid extends StatelessWidget {
  final List<Map<String, String>> characters = [
    {'name': 'الجوكر', 'image': "assets/images/car1.webp"},
    {'name': 'هانيبال ليكتر', 'image': 'assets/images/car2.webp'},
  ];

  CharacterGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'الشخصيات التي ستبدع في تمثيلها',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          shrinkWrap: true, // لضمان أن الشبكة لا تأخذ ارتفاعًا غير محدود
          physics: const NeverScrollableScrollPhysics(), // تعطيل سكرول الشبكة
          itemCount: characters.length,
          itemBuilder: (context, index) {
            return CharacterCard(
              name: characters[index]['name']!,
              imageUrl: characters[index]['image']!,
            );
          },
        ),
      ],
    );
  }
}

class CharacterCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CharacterCard({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: 150,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

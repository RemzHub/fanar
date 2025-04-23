import 'package:flutter/material.dart';

class TestResultWidget extends StatelessWidget {
  final Map<String, double> results;
  final List<Map<String, String>> celebrities;

  const TestResultWidget({
    super.key,
    required this.results,
    required this.celebrities,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'نتائج التحليل',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ],
            ),
          ),
          _buildCurrentLevelCard(),
          _buildResultsGrid(),
          _buildSimilarCelebrities(),
        ],
      ),
    );
  }

  Widget _buildCurrentLevelCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          CircularProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.orange.shade100,
            valueColor: AlwaysStoppedAnimation(Colors.orange.shade400),
            strokeWidth: 8,
          ),
          const SizedBox(height: 16),
          Text(
            'مستواك الحالي',
            style: TextStyle(
              color: Colors.orange.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text('تقدم جيد جداً', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildResultsGrid() {
    final categories = [
      {
        'title': 'سمة الحزن',
        'value': results['sad'] ?? 0,
        'color': Colors.purple,
      },
      {
        'title': 'التعابير الحركية',
        'value': results['expression'] ?? 0,
        'color': Colors.blue,
      },
      {
        'title': 'سمة الغضب',
        'value': results['angry'] ?? 0,
        'color': Colors.red,
      },
      {
        'title': 'سمة الفرح',
        'value': results['happy'] ?? 0,
        'color': Colors.orange,
      },
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children:
          categories.map((category) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: category['value'] as double,
                    backgroundColor: (category['color'] as Color).withOpacity(
                      0.1,
                    ),
                    valueColor: AlwaysStoppedAnimation(
                      category['color'] as Color,
                    ),
                    strokeWidth: 6,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'مستوى جيد جداً',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSimilarCelebrities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'تطابق مع الفنانين الآن',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: celebrities.length,
            itemBuilder: (context, index) {
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(celebrities[index]['image']!),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      celebrities[index]['name']!,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

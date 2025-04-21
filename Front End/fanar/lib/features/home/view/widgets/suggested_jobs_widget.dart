import 'package:fanar/features/home/view/widgets/homepage_heading_title.dart';
import 'package:flutter/material.dart';

class SuggestedJobsWidget extends StatelessWidget {
  const SuggestedJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomepageHeadingTitle(title: 'العروض المقترحة'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExpandableRoleCard(
                title: "دور درامي في مسرحية تاريخية",
                subtitle: "المطلوب",
                requirement: "شخص واحد",
                details: "هذه التفاصيل الإضافية عن الدور.",
              ),
              ExpandableRoleCard(
                title: "دور كوميدي في عرض حصري",
                subtitle: "المطلوب",
                requirement: "3 أشخاص",
                details: "تفاصيل إضافية عن العرض الكوميدي.",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpandableRoleCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String requirement;
  final String details;

  const ExpandableRoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.requirement,
    required this.details,
  });

  @override
  State<ExpandableRoleCard> createState() => _ExpandableRoleCardState();
}

class _ExpandableRoleCardState extends State<ExpandableRoleCard> {
  bool _isExpanded = false; // للتحكم في حالة التوسع

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // عكس حالة التوسع عند النقر
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // مدة الحركة
          curve: Curves.easeInOut, // منحنى الحركة
          width: _isExpanded ? 260 : 230, // العرض يتغير
          height: _isExpanded ? 260 : 230, // الطول يتغير
          decoration: BoxDecoration(
            color: Color(0xFF0F2027),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white24,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.requirement,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              if (_isExpanded) // يظهر التفاصيل فقط إذا تم التوسع
                Text(
                  widget.details,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "قراءة المتطلبات والتقديم",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ملف: main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingScreenController extends GetxController {
  int selectedIndexB = 2;

  void changebottem(int index) {
    selectedIndexB = index;
    update();

    // التنقل حسب الاختيار
    switch (selectedIndexB) {
      case 0:
        Get.offNamed("/HomePage");
        break;
      case 1:
        Get.offNamed("/serach");
        break;
      case 2:
        Get.offNamed("/ChatScren");
        break;
      case 3:
        Get.offNamed("/lib");
        break;
      case 4:
        Get.offNamed("/acu");
        break;
    }
  }
}

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final TrainingScreenController controller =
      Get.put(TrainingScreenController());

  // المتغيرات المفقودة
  final Color backgroundColor = Color(0xFF0F2C3A);
  final Color textColor = Colors.white;
  final Color secondaryTextColor = Colors.grey;
  final Color primaryColor = Color(0xFF4CAF50);

  int _selectedTraining = 1; // القيمة الافتراضية للتدريب

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصورة الشخصية
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/images/angger.webp'), // صورة افتراضية
                ),
              ),
              SizedBox(height: 16),
              // النصوص العلوية
              Center(
                child: Column(
                  children: [
                    Text(
                      'تحسين سمة الغضب',
                      style: TextStyle(
                        fontSize: 24,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'لنبدأ الآن بتطوير أدائك بشكل أكثر تفصيلاً.',
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // تقييمك السابق
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: 0.65, // القيمة النسبية
                            strokeWidth: 8,
                            backgroundColor: Colors.grey.shade800,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                        Text(
                          '65%',
                          style: TextStyle(
                            fontSize: 24,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'مستواك جيد',
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'وبتدريب إضافي ستصبح أفضل',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              // اختيار التدريب
              Text(
                'اختر التدريب الذي تريد أن تبدأ به',
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    RadioListTile(
                      value: 1,
                      groupValue: _selectedTraining,
                      onChanged: (value) {
                        setState(() {
                          _selectedTraining = value as int;
                        });
                      },
                      activeColor: primaryColor,
                      title: Text(
                        'تصوير الفيديو',
                        style: TextStyle(color: textColor),
                      ),
                      secondary: Icon(Icons.videocam, color: textColor),
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: _selectedTraining,
                      onChanged: (value) {
                        setState(() {
                          _selectedTraining = value as int;
                        });
                      },
                      activeColor: primaryColor,
                      title: Text(
                        'التدريب الصوتي',
                        style: TextStyle(color: textColor),
                      ),
                      secondary: Icon(Icons.mic, color: textColor),
                    ),
                    RadioListTile(
                      value: 3,
                      groupValue: _selectedTraining,
                      onChanged: (value) {
                        setState(() {
                          _selectedTraining = value as int;
                        });
                      },
                      activeColor: primaryColor,
                      title: Text(
                        'مارس',
                        style: TextStyle(color: textColor),
                      ),
                      secondary: Icon(Icons.chat, color: textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // زر البدء
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // رسالة عند اختيار تدريب
                    final trainingNames = {
                      1: "تصوير الفيديو",
                      2: "التدريب الصوتي",
                      3: "مارس",
                    };
                    final selectedTrainingName =
                        trainingNames[_selectedTraining]!;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'تم اختيار: $selectedTrainingName',
                          style: TextStyle(color: textColor),
                        ),
                        backgroundColor: primaryColor,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'بدء التدريب',
                    style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<TrainingScreenController>(
          builder: (_) => BottomNavigationBar(
            backgroundColor: Color(0xFF0F2027),
            currentIndex: controller.selectedIndexB,
            onTap: (index) => controller.changebottem(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "الرئيسية"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.theater_comedy), label: "دوراتي"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: 40), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.group), label: "فرصي"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
            ],
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}

// Placeholder لصفحات أخرى
class PlaceholderWidget extends StatelessWidget {
  final String title;

  PlaceholderWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JVoiceRecordController extends GetxController {
  var isRecording = false.obs;
  var isPlaying = false.obs;
  var recordingComplete = false.obs;
}

class JoyScreen extends StatelessWidget {
  final JVoiceRecordController controller = Get.put(JVoiceRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 140),
              // Title and Instructions
              Column(
                children: [
                  const Text(
                    "سمة الفرح",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'سجل صوتك أثناء قراءة النص مع التركيز\n على التعبير عن الفرح والفرحة بنبرة مرتفعة\nتعكس السعادة العارمة',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22,
                        height: 1.5,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(86, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "لقد فعلناها أخيرًا  \nكل الجهود لم تذهب سدى يا إلهي لا أصدق أننا فزنا بالجائزة الكبرى ! الجميع سيعرف الآن أن فريقنا هو الأفضل",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              // Audio Controls Section
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  // Recording/Playback State
                  Obx(() {
                    if (!controller.recordingComplete.value) {
                      return Text(
                        controller.isRecording.value
                            ? "جاري التسجيل..."
                            : "اضغط على المايك لبدء التسجيل",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      );
                    } else {
                      return const Text(
                        "تم تسجيل صوتك بنجاح",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      );
                    }
                  }),
                  const SizedBox(height: 2),
                  // Record Button
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                      ),
                      Obx(() {
                        if (!controller.recordingComplete.value) {
                          return IconButton(
                            onPressed: () {
                              if (controller.isRecording.value) {
                                controller.isRecording.value = false;
                                controller.recordingComplete.value = true;
                              } else {
                                controller.isRecording.value = true;
                              }
                            },
                            icon: Icon(
                              controller.isRecording.value
                                  ? Icons.mic
                                  : Icons.mic_none,
                              size: 100,
                              color: controller.isRecording.value
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  // Audio Waveform & Controls
                  Obx(() {
                    if (controller.recordingComplete.value) {
                      return Column(
                        children: [
                          // Simulated Audio Waveform
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF0F2027),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.graphic_eq,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "تسجيلك الصوتي",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Play and Re-record Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.isPlaying.value =
                                      !controller.isPlaying.value;
                                },
                                icon: Icon(
                                  controller.isPlaying.value
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  size: 50,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                onPressed: () {
                                  controller.recordingComplete.value = false;
                                  controller.isRecording.value = false;
                                },
                                icon: const Icon(
                                  Icons.replay,
                                  size: 50,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  const SizedBox(height: 20),
                  // Next Trait Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/sadtest");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D3FD3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "إنتقل للسمة التالية",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

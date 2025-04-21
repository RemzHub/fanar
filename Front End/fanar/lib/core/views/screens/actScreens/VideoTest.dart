import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

class VVoiceRecordController extends GetxController {
  var isRecording = false.obs;
  var isPlaying = false.obs;
  var recordingComplete = false.obs;
  late VideoPlayerController videoPlayerController;
  var isInitialized = false.obs; // حالة تهيئة الفيديو
  var isLoading = false.obs; // حالة التحميل عند اختيار فيديو جديد

  @override
  void onInit() {
    super.onInit();
    initializeVideo("assets/images/video.mp4"); // تهيئة فيديو افتراضي
  }

  void initializeVideo(String videoPath) {
    videoPlayerController = VideoPlayerController.file(File(videoPath))
      ..initialize().then((_) {
        isInitialized.value = true; // تحديث الحالة عند اكتمال التهيئة
        videoPlayerController.play(); // تشغيل الفيديو تلقائيًا
        isPlaying.value = true;
      });
  }

  Future<void> pickVideoFromCameraOrGallery(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    isLoading.value = true;
    final XFile? pickedFile = await picker.pickVideo(source: source);
    if (pickedFile != null) {
      // تهيئة الفيديو الجديد
      videoPlayerController.dispose(); // تحرير الموارد القديمة
      isInitialized.value = false; // إعادة ضبط حالة التهيئة
      initializeVideo(pickedFile.path);
    }
    isLoading.value = false;
  }

  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      isPlaying.value = false; // تحديث الحالة للإيقاف
    } else {
      videoPlayerController.play();
      isPlaying.value = true; // تحديث الحالة للتشغيل
    }
  }

  @override
  void onClose() {
    videoPlayerController.dispose(); // تحرير الموارد عند الخروج
    super.onClose();
  }
}

class videoScreen extends StatelessWidget {
  final VVoiceRecordController controller = Get.put(VVoiceRecordController());

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
              Obx(() {
                if (controller.isLoading.value) {
                  // عرض مؤشر تحميل أثناء اختيار الفيديو
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (!controller.isInitialized.value) {
                  // عرض مؤشر تحميل أثناء تهيئة الفيديو
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                return Column(
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          AspectRatio(
                            aspectRatio: controller
                                .videoPlayerController.value.aspectRatio,
                            child:
                                VideoPlayer(controller.videoPlayerController),
                          ),
                          VideoProgressIndicator(
                            controller.videoPlayerController,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: Colors.blue,
                              bufferedColor: Colors.grey,
                              backgroundColor: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              controller.isPlaying.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () {
                              controller.togglePlayPause();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller
                          .pickVideoFromCameraOrGallery(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("فتح الكاميرا"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D3FD3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller
                          .pickVideoFromCameraOrGallery(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.video_library),
                    label: const Text("اختر فيديو"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D3FD3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(86, 0, 0, 0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  """انتظر لحظة .... ماذا؟ هل هذا يعني أن المفتاح كان هنا طوال الوقت ؟ لكن ... كيف لم ألاحظ ذلك ؟ هذا لا يصدق""",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/ResultScreen");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D3FD3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "اعرف النتائج",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

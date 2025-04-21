import 'package:fanar/core/common/controller/city_controller.dart';
import 'package:fanar/core/common/controller/country_controller.dart';
import 'package:fanar/core/common/controller/gender_controller.dart';
import 'package:fanar/core/common/controller/media_controller.dart';
import 'package:fanar/core/common/controller/role_controller.dart';
import 'package:fanar/core/common/controller/supported_country_controller.dart';
import 'package:fanar/core/network/network_status_controller.dart';
import 'package:fanar/core/routes/app_routes.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/application/logic/application_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/opportunity/controller/opportunity_controller.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io';
import 'dart:typed_data';

void main() {
  Get.put(NetworkStatusController(), permanent: true);
  Get.put(AuthController());
  Get.put(SupportedCountryController()).fetchCountries();
  Get.put(CountryController()).fetchCountries();
  Get.put(CityController()).fetchCities();
  Get.put(RoleController()).fetchRoles();
  Get.put(GenderController()).fetchGenders();
  Get.put(MediaController());
  Get.put(OpportunityController()).fetchOpportunities();
  Get.put(ApplicationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: ModeTest(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: DevicePreview.appBuilder,
      theme: ThemeController().lightTheme,
      debugShowCheckedModeBanner: false,
      unknownRoute: AppRoutes.unknownScreenGetPage,
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.getPages,
      locale: Locale('ar', 'SA'),
    );
  }
}

class ModeTest extends StatefulWidget {
  const ModeTest({
    super.key,
  });

  @override
  State<ModeTest> createState() => _ModeTestState();
}

class _ModeTestState extends State<ModeTest> {
  Map<int, String> moodMap = {
    0: "غاضب",
    1: "متقرف",
    2: "خائف",
    3: "سعيد",
    4: "محايد",
    5: "حزين",
    6: "متفاجئ",
  };

  final picker = ImagePicker();
  Interpreter? _interpreter;
  File? _selectedImage;
  String _result = 'No result yet';

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/models/model2.tflite');
    debugPrint('Model Loaded!');
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImage = imageFile;
      _result = 'Processing...';
    });

    final mood = await predictedMood(imageFile);
    setState(() {
      _result = mood;
    });
  }

  Future<String> predictedMood(File imageFile) async {
    final rawBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(rawBytes)!;
    final resized = img.copyResize(image, width: 224, height: 224);

    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(
          224,
          (x) {
            final pixel = resized.getPixel(x, y);
            return [
              (pixel.r - 127.5) / 127.5,
              (pixel.g - 127.5) / 127.5,
              (pixel.b - 127.5) / 127.5,
            ];
          },
        ),
      ),
    ); // Prepare output
    print(input);
    final output = List.filled(7, 0.0).reshape([1, 7]);

    // Run model
    _interpreter!.run(input, output);

    final scores = output[0];
    final maxIndex = scores.indexWhere(
        (e) => e == scores.reduce((double a, double b) => a > b ? a : b));
    final confidence = (scores[maxIndex] * 100).toStringAsFixed(1);
    return "${moodMap[maxIndex] ?? "Unknown"} ($confidence%)";
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  void initState() {
    loadModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mood Detector")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200),
            const SizedBox(height: 20),
            Text(_result, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:fanar/features/test/widgets/test_stepper_indicator.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

class ExpressionTestWidget extends StatefulWidget {
  const ExpressionTestWidget({super.key});

  @override
  State<ExpressionTestWidget> createState() => _ExpressionTestWidgetState();
}

class _ExpressionTestWidgetState extends State<ExpressionTestWidget> {
  String? videoPath;
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(String path) async {
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(File(path));
    await _videoController!.initialize();
    setState(() {});
  }

  Widget _buildVideoPreview() {
    if (videoPath == null || _videoController == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _videoController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.orange.shade800,
                ),
                onPressed: () {
                  setState(() {
                    _videoController!.value.isPlaying
                        ? _videoController!.pause()
                        : _videoController!.play();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TestStepperIndicator(index: 4),
        const SizedBox(height: 72.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تعابير الوجه',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text('حاول تمثيل مشهدك المفضل'),
              const SizedBox(height: 32.0),
              ClipUploadWidget(
                onClipSelected: (path) async {
                  setState(() {
                    videoPath = path;
                  });
                  await _initializeVideo(path);
                },
              ),
              if (videoPath != null) _buildVideoPreview(),
            ],
          ),
        ),
      ],
    );
  }
}

class ClipUploadWidget extends StatefulWidget {
  final Function(String) onClipSelected;
  final double maxDuration;

  const ClipUploadWidget({
    super.key,
    required this.onClipSelected,
    this.maxDuration = 5, // 5 seconds default
  });

  @override
  State<ClipUploadWidget> createState() => _ClipUploadWidgetState();
}

class _ClipUploadWidgetState extends State<ClipUploadWidget> {
  final _picker = ImagePicker();
  String? _selectedClipPath;

  Future<void> _recordVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: Duration(seconds: widget.maxDuration.toInt()),
      );

      if (video != null) {
        setState(() {
          _selectedClipPath = video.path;
        });
        widget.onClipSelected(video.path);
      }
    } catch (e) {
      print('Error recording video: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

      if (video != null) {
        setState(() {
          _selectedClipPath = video.path;
        });
        widget.onClipSelected(video.path);
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.videocam_outlined, color: Colors.orange.shade800),
              const SizedBox(width: 8),
              Text(
                'اضافة مقطع قصير',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'مقطع لا يتجاوز ${widget.maxDuration} ث',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _recordVideo,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange.shade200, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _selectedClipPath != null ? 'تم تسجيل المقطع' : 'بدء التصوير',
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          if (_selectedClipPath != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton.icon(
                onPressed: _pickFromGallery,
                icon: Icon(
                  Icons.photo_library_outlined,
                  color: Colors.orange.shade800,
                  size: 20,
                ),
                label: Text(
                  'اختيار من المعرض',
                  style: TextStyle(color: Colors.orange.shade800, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

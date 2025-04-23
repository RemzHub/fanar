import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class RecordWidget extends StatefulWidget {
  final Function(String?) onFinished;

  const RecordWidget({super.key, required this.onFinished});

  @override
  State<RecordWidget> createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget>
    with SingleTickerProviderStateMixin {
  final _audioRecorder = AudioRecorder();

  late AnimationController _animationController;
  bool _isRecording = false;
  String? _audioFilePath;
  Duration _recordDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  Future<void> _startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/voice_record_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: filePath,
      );

      setState(() {
        _isRecording = true;
        _audioFilePath = filePath;
        _recordDuration = Duration.zero;
      });

      _startDurationTimer();
    }
  }

  void _startDurationTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isRecording) {
        setState(() {
          _recordDuration += const Duration(seconds: 1);
        });
        _startDurationTimer();
      }
    });
  }

  Future<void> _stopRecording() async {
    final path = await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
      _audioFilePath = path;
    });

    if (path != null) {
      widget.onFinished(path);
      Navigator.pop(context);
    }
  }

  void _cancelRecording() async {
    if (_isRecording) {
      await _audioRecorder.stop();
    }
    widget.onFinished(null);
    Navigator.pop(context);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تسجيل صوتي',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: _cancelRecording,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 32),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color:
                    _isRecording
                        ? Colors.red.withOpacity(0.1)
                        : const Color(0xFF003141),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isRecording)
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.all(32.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.red.withOpacity(
                                _animationController.value,
                              ),
                              width: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  Icon(
                    Icons.mic,
                    color: _isRecording ? Colors.red : Colors.white,
                    size: 48.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _isRecording ? _formatDuration(_recordDuration) : 'اضغط للبدء',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 32),
            _buildActionButton(
              icon: _isRecording ? Icons.stop : Icons.mic,
              onTap: _isRecording ? _stopRecording : _startRecording,
              color: _isRecording ? Colors.red : Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF0E4),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

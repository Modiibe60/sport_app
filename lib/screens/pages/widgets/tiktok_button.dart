import 'package:flutter/material.dart';

class TikTokButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onStart;
  final VoidCallback onStop;

  const TikTokButton({
    super.key,
    required this.isRecording,
    required this.onStart,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isRecording ? onStop : onStart,
      child: CircleAvatar(
        radius: 35,
        backgroundColor: isRecording ? Colors.red : Colors.white,
        child: Icon(
          isRecording ? Icons.stop : Icons.fiber_manual_record,
          color: isRecording ? Colors.white : Colors.red,
          size: 40,
        ),
      ),
    );
  }
}

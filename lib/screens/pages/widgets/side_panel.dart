import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  final VoidCallback onGalleryPick;

  const SidePanel({super.key, required this.onGalleryPick});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.video_library, color: Colors.white, size: 30),
          onPressed: onGalleryPick,
        ),
      ],
    );
  }
}

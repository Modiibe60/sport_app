import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'edit_video_page.dart';
import 'widgets/tiktok_button.dart';

class RecordVideoPage extends StatefulWidget {
  const RecordVideoPage({super.key});

  @override
  RecordVideoPageState createState() => RecordVideoPageState();
}

class RecordVideoPageState extends State<RecordVideoPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isRecording = false;
  bool _isFlashOn = false;
  late List<CameraDescription> _cameras;
  int _cameraIndex = 0; // 0 = back camera, 1 = front camera
  VideoPlayerController? _videoController; // For previewing recorded video

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _controller =
          CameraController(_cameras[_cameraIndex], ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller.value.isInitialized) {
      _isFlashOn = !_isFlashOn;
      await _controller
          .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length > 1) {
      _cameraIndex = _cameraIndex == 0 ? 1 : 0;
      await _controller.dispose();
      _initializeCamera();
    }
  }

  Future<void> _startRecording() async {
    if (!_controller.value.isRecordingVideo) {
      await _controller.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_controller.value.isRecordingVideo) {
      XFile videoFile = await _controller.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });
      // Navigate to the EditVideoPage after stopping the recording
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EditVideoPage(videoFile: File(videoFile.path)),
          ),
        );
      }

      // Load video into video player
      _videoController = VideoPlayerController.file(File(videoFile.path))
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EditVideoPage(videoFile: File(videoFile.path)),
          ),
        );
      }
    }
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditVideoPage(videoFile: File(pickedFile.path)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? CameraPreview(_controller)
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),

          // Floating Buttons (Left Side)
          Positioned(
            top: 80,
            left: 10,
            child: Column(
              children: [
                _floatingIconButton(
                    Icons.flash_on, _toggleFlash, _isFlashOn), // Flash
                _floatingIconButton(
                    Icons.switch_camera, _switchCamera), // Switch Camera
                _floatingIconButton(
                    Icons.timer, () {}), // Timer (To be implemented)
                _floatingIconButton(
                    Icons.brush, () {}), // Filters (To be implemented)
                _floatingIconButton(
                    Icons.music_note, () {}), // Add Music (To be implemented)
              ],
            ),
          ),

          // Floating Close Button (Top Right)
          Positioned(
            top: 50,
            right: 15,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Record Button and Effects
          Positioned(
            bottom: 80,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: TikTokButton(
              isRecording: _isRecording,
              onStart: _startRecording,
              onStop: _stopRecording,
            ),
          ),

          // Gallery & Effects Buttons
          Positioned(
            bottom: 85,
            left: 30,
            child: _floatingIconButton(Icons.photo, _pickVideo), // Open Gallery
          ),
          Positioned(
            bottom: 85,
            right: 30,
            child: _floatingIconButton(
                Icons.face, () {}), // Effects (To be implemented)
          ),

          // Video Preview (If Available)
          if (_videoController != null && _videoController!.value.isInitialized)
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              ),
            ),
        ],
      ),
    );
  }

  // Widget for Floating Buttons
  Widget _floatingIconButton(IconData icon, VoidCallback onPressed,
      [bool isActive = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          radius: 25,
          backgroundColor:
              isActive ? Colors.red : Colors.black.withOpacity(0.6),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

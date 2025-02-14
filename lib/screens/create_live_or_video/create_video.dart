import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CreateVideoPage extends StatefulWidget {
  final CameraDescription camera;

  const CreateVideoPage({super.key, required this.camera});

  @override
  // ignore: library_private_types_in_public_api
  _CreateVideoPageState createState() => _CreateVideoPageState();
}

class _CreateVideoPageState extends State<CreateVideoPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;
  bool _isRecording = false;
  XFile? _videoFile;
  VideoPlayerController? _videoPlayerController;
  final ImagePicker _picker = ImagePicker();
  bool _isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera(widget.camera);
  }

  Future<void> _initializeCamera(CameraDescription camera) async {
    _cameras = await availableCameras();
    _controller = CameraController(camera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void _switchCamera() async {
    setState(() => _isFrontCamera = !_isFrontCamera);
    CameraDescription newCamera =
        _isFrontCamera ? _cameras[1] : _cameras[0]; // Toggle cameras
    await _initializeCamera(newCamera);
  }

  Future<void> _startRecording() async {
    await _initializeControllerFuture;
    if (!_controller.value.isRecordingVideo) {
      await _controller.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  Future<void> _stopRecording() async {
    if (_controller.value.isRecordingVideo) {
      XFile video = await _controller.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _videoFile = video;
        _videoPlayerController = VideoPlayerController.file(File(video.path))
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController!.play();
          });
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = pickedFile;
        _videoPlayerController =
            VideoPlayerController.file(File(pickedFile.path))
              ..initialize().then((_) {
                setState(() {});
                _videoPlayerController!.play();
              });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: _videoFile == null
                ? FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_controller);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : VideoPlayer(_videoPlayerController!),
          ),

          // 🎵 Top Bar (Close, Sounds, Effects)
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "Sounds",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.music_note, color: Colors.white),
                  onPressed: () {}, // Add music feature here
                ),
              ],
            ),
          ),

          // 🎥 Controls (Flip Camera, Effects)
          Positioned(
            left: 16,
            top: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: [
                _buildControlButton(
                    Icons.flip_camera_ios, "Flip", _switchCamera),
                const SizedBox(height: 16),
                _buildControlButton(Icons.auto_awesome, "Effects",
                    () {}), // Placeholder for future effects
              ],
            ),
          ),

          // 🎬 Record & Upload Buttons
          Positioned(
            bottom: 80,
            left: MediaQuery.of(context).size.width * 0.5 - 35,
            child: GestureDetector(
              onTap: _isRecording ? _stopRecording : _startRecording,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: _isRecording ? Colors.red : Colors.white,
                child: Icon(
                  _isRecording ? Icons.stop : Icons.fiber_manual_record,
                  color: _isRecording ? Colors.white : Colors.red,
                  size: 40,
                ),
              ),
            ),
          ),

          // 📸 Upload from Gallery
          Positioned(
            bottom: 85,
            right: 16,
            child:
                _buildControlButton(Icons.photo_library, "Upload", _pickVideo),
          ),

          // ✍️ Write a Post
          if (_videoFile != null)
            Positioned(
              bottom: 150,
              left: 20,
              right: 20,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Write a caption...",
                  // ignore: deprecated_member_use
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  filled: true,
                  // ignore: deprecated_member_use
                  fillColor: Colors.black.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

          // ✅ Post Button
          if (_videoFile != null)
            Positioned(
              bottom: 40,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {}, // Implement posting logic
                child: const Text("Post",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 22,
            // ignore: deprecated_member_use
            backgroundColor: Colors.black.withOpacity(0.5),
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

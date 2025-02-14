import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateLivePage extends StatefulWidget {
  final CameraDescription camera;

  const CreateLivePage({super.key, required this.camera});

  @override
  // ignore: library_private_types_in_public_api
  _CreateLivePageState createState() => _CreateLivePageState();
}

class _CreateLivePageState extends State<CreateLivePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isLive = false;
  bool _isEnding = false;
  bool _isMuted = false;
  XFile? _coverImage;
  bool _isFrontCamera = true;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  final List<String> _messages = [];

  void _switchCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription newCamera = _isFrontCamera
        ? cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.back)
        : cameras
            .firstWhere((c) => c.lensDirection == CameraLensDirection.front);

    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    await _initializeCamera(newCamera);
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera(widget.camera);
  }

  Future<void> _initializeCamera(CameraDescription camera) async {
    _controller = CameraController(camera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickCoverImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _coverImage = image);
    }
  }

  void _startLive() {
    if (_coverImage == null) {
      _showMessage("Please upload a cover image before going live.");
      return;
    }
    setState(() => _isLive = true);
  }

  void _endLive() {
    setState(() => _isEnding = true);
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
  }

  void _sendMessage() {
    if (_chatController.text.isNotEmpty) {
      setState(() {
        _messages.insert(0, _chatController.text);
        _chatController.clear();
      });
    }
  }

  void _resetLiveSession() {
    setState(() {
      _isLive = false;
      _isEnding = false;
      _messages.clear();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _controller.dispose();
    _chatController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_isLive)
            Positioned.fill(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          if (!_isLive && !_isEnding) _buildPreLiveUI(),
          if (_isLive) _buildLiveStreamingUI(),
          if (_isEnding) _buildEndingLiveUI(),
        ],
      ),
    );
  }

  Widget _buildPreLiveUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _pickCoverImage,
            child: _coverImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(File(_coverImage!.path),
                        height: 120, width: 120, fit: BoxFit.cover),
                  )
                : Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
          ),
          const SizedBox(height: 20),
          _buildTextField(_titleController, "Enter Live Title..."),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: _startLive,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Text("Go Live", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveStreamingUI() {
    return Stack(
      children: [
        Positioned(
          top: 40,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(8)),
            child: const Text("Live", style: TextStyle(color: Colors.white)),
          ),
        ),
        Positioned(
          left: 16,
          top: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              _buildControlButton(Icons.flip_camera_ios, _switchCamera),
              const SizedBox(height: 16),
              _buildControlButton(
                  _isMuted ? Icons.mic_off : Icons.mic, _toggleMute),
            ],
          ),
        ),
        Positioned(
          bottom: 100,
          left: 16,
          right: 16,
          child: Column(
            children: [
              _buildChatBox(),
              _buildTextField(_chatController, "Add chat...", _sendMessage),
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          right: 16,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: _endLive,
            child: const Text("Ending", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildEndingLiveUI() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Your live broadcast video has finished.\nYou can publish it or analyze it.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEndingButton(
                    Icons.upload, "Post Video", _resetLiveSession),
                const SizedBox(width: 16),
                _buildEndingButton(
                    Icons.analytics, "Analyze", _resetLiveSession),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEndingButton(
                    Icons.delete, "Delete", _resetLiveSession, Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22,
        // ignore: deprecated_member_use
        backgroundColor: Colors.black.withOpacity(0.5),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      [VoidCallback? onSubmit]) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        // ignore: deprecated_member_use
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        filled: true,
        // ignore: deprecated_member_use
        fillColor: Colors.black.withOpacity(0.5),
      ),
      onSubmitted: (_) => onSubmit?.call(),
    );
  }

  Widget _buildChatBox() {
    return Container(
      height: 150,
      // ignore: deprecated_member_use
      color: const Color.fromARGB(255, 78, 77, 77).withOpacity(0.4),
      child: ListView(
          reverse: true,
          children: _messages
              .map((msg) => Text(msg, style: TextStyle(color: Colors.white)))
              .toList()),
    );
  }
}

Widget _buildEndingButton(IconData icon, String label, VoidCallback onTap,
    [Color? color]) {
  return ElevatedButton.icon(
    onPressed: onTap,
    icon: Icon(icon, color: Colors.white),
    label: Text(label),
    style: ElevatedButton.styleFrom(backgroundColor: color ?? Colors.white),
  );
}

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateLivePage extends StatefulWidget {
  final CameraDescription camera;

  const CreateLivePage({super.key, required this.camera});

  @override
  _CreateLivePageState createState() => _CreateLivePageState();
}

class _CreateLivePageState extends State<CreateLivePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isLive = false;
  bool _isFrontCamera = true;
  bool _isMuted = false;
  // ignore: unused_field
  bool _isChatVisible = true;
  XFile? _coverImage;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  final List<String> _messages = [];

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

  void _switchCamera() {
    setState(() => _isFrontCamera = !_isFrontCamera);
    CameraDescription newCamera = _isFrontCamera
        ? widget.camera
        : CameraDescription(
            name: "back",
            lensDirection: CameraLensDirection.back,
            sensorOrientation: 0,
          );
    _initializeCamera(newCamera);
  }

  void _startLive() {
    setState(() => _isLive = true);
  }

  void _endLive() {
    setState(() => _isLive = false);
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

  void _openMusicDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Music"),
        content: const Text("Music selection feature coming soon."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _postVideo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Video saved to gallery!")),
    );
  }

  void _analyzeStream() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Opening analytics...")),
    );
  }

  void _resetLiveSession() {
    setState(() {
      _messages.clear();
      _isLive = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🎥 Camera Feed
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

          // 🟢 Pre-Live Setup UI
          if (!_isLive)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _pickCoverImage,
                    child: _coverImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(File(_coverImage!.path),
                                height: 120),
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(_titleController, "Enter live title..."),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _startLive,
                    child: const Text("Go Live",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

          // 🔴 Live Streaming UI
          if (_isLive)
            Stack(
              children: [
                Positioned(
                  left: 16,
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: [
                      _buildControlButton(
                          Icons.flip_camera_ios, "Flip", _switchCamera),
                      const SizedBox(height: 16),
                      _buildControlButton(
                          Icons.music_note, "Music", _openMusicDialog),
                      const SizedBox(height: 16),
                      _buildControlButton(Icons.mic_off,
                          _isMuted ? "Unmute" : "Mute", _toggleMute),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 120,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      _buildChatBox(),
                      _buildTextField(
                          _chatController, "Add chat...", _sendMessage),
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _endLive,
                    child: const Text("End Live",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),

          // 📊 End Stream Summary
          if (!_isLive && _messages.isNotEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Your live broadcast has ended.",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _postVideo,
                        child: const Text("Post Video"),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _analyzeStream,
                        child: const Text("Analyze"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _resetLiveSession,
                    child: const Text("Delete"),
                  ),
                ],
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
            backgroundColor: Colors.black.withOpacity(0.5),
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      [VoidCallback? onSubmit]) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
      onSubmitted: (_) => onSubmit?.call(),
    );
  }

  Widget _buildChatBox() {
    return Container(
      height: 150,
      child: ListView.builder(
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return Text(_messages[index],
              style: const TextStyle(color: Colors.white));
        },
      ),
    );
  }
}

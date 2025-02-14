import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Sample list of live video URLs (Replace with actual live stream links)
final List<String> liveStreamUrls = [
  'https://your-stream-url-1.m3u8',
  'https://your-stream-url-2.m3u8',
  'https://your-stream-url-3.m3u8',
];

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  // ignore: prefer_final_fields
  PageController _pageController = PageController();
  final List<VideoPlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (var url in liveStreamUrls) {
      // ignore: deprecated_member_use
      final controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        })
        ..setLooping(true)
        ..play();
      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _controllers.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              _controllers[index].value.isInitialized
                  ? Center(
                      child: AspectRatio(
                        aspectRatio: _controllers[index].value.aspectRatio,
                        child: VideoPlayer(_controllers[index]),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
              _buildFloatingUI(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFloatingUI() {
    return Positioned(
      right: 16,
      bottom: 100,
      child: Column(
        children: [
          _buildIconButton(Icons.favorite, "24.5K"),
          _buildIconButton(Icons.comment, "3.1K"),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String count) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: () {},
        ),
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

/// Define the steps in the flow.
enum FacialRecognitionStep {
  instructions,
  processing,
  accepted,
}

class FacialRecognitionCameraFlow extends StatefulWidget {
  // ignore: use_super_parameters
  const FacialRecognitionCameraFlow({Key? key}) : super(key: key);

  @override
  State<FacialRecognitionCameraFlow> createState() =>
      _FacialRecognitionCameraFlowState();
}

class _FacialRecognitionCameraFlowState
    extends State<FacialRecognitionCameraFlow> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  FacialRecognitionStep _currentStep = FacialRecognitionStep.instructions;
  // ignore: unused_field
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  /// Initializes the front camera.
  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  /// Called when the user taps the Capture button.
  Future<void> _onCapturePressed() async {
    try {
      // Capture the image from the camera.
      final image = await _cameraController.takePicture();
      setState(() {
        _capturedImage = image;
        _currentStep = FacialRecognitionStep.processing;
      });

      // Simulate processing delay (replace this with your actual processing logic)
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _currentStep = FacialRecognitionStep.accepted;
          });
          // Optionally, wait before returning or navigating away.
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pop(context, true);
            }
          });
        }
      });
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // While the camera is initializing, show a loading indicator.
    if (!_isCameraInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Facial Recognition"),
        backgroundColor: Colors.black,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildCurrentStepWidget(),
      ),
    );
  }

  /// Builds the widget for the current step.
  Widget _buildCurrentStepWidget() {
    switch (_currentStep) {
      case FacialRecognitionStep.instructions:
        return _buildInstructionsScreen();
      case FacialRecognitionStep.processing:
        return _buildProcessingScreen();
      case FacialRecognitionStep.accepted:
        return _buildAcceptedScreen();
    }
  }

  /// Screen 1: Display the camera preview with an overlay and a capture button.
  Widget _buildInstructionsScreen() {
    return Stack(
      key: const ValueKey('instructions'),
      children: [
        // Live camera preview.
        CameraPreview(_cameraController),
        // Circular overlay as a guide frame.
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange, width: 3),
            ),
          ),
        ),
        // Instruction text overlay.
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "Position your face within the frame\nand tap the capture button.",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        // Capture button.
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: _onCapturePressed,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Capture",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Screen 2: Processing screen with a progress indicator.
  Widget _buildProcessingScreen() {
    return Center(
      key: const ValueKey('processing'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
          SizedBox(height: 20),
          Text(
            "Processing...",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// Screen 3: Accepted screen with a success indicator.
  Widget _buildAcceptedScreen() {
    return Center(
      key: const ValueKey('accepted'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 3),
                ),
              ),
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Accepted",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

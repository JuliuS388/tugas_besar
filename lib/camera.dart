import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraView({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _cameraController;
  int _currentCameraIndex = 0;
  bool _isInitialized = false;
  double _buttonScale = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isEmpty) return;

    _cameraController?.dispose();

    final CameraController cameraController = CameraController(
      widget.cameras[_currentCameraIndex],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await cameraController.initialize();

      if (mounted) {
        setState(() {
          _cameraController = cameraController;
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Camera initialization error: $e');
    }
  }

  void _switchCamera() async {
    if (widget.cameras.length > 1) {
      try {
        if (_cameraController != null &&
            _cameraController!.value.isStreamingImages) {
          await _cameraController?.stopImageStream();
        }
      } catch (e) {
        print('Error stopping image stream: $e');
      }

      await _cameraController?.dispose();

      _currentCameraIndex = (_currentCameraIndex + 1) % widget.cameras.length;

      setState(() {
        _isInitialized = false;
      });

      final CameraController newController = CameraController(
        widget.cameras[_currentCameraIndex],
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      try {
        await newController.initialize();

        _cameraController = newController;

        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      } on CameraException catch (e) {
        print('Error switching camera: ${e.code}, ${e.description}');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to switch camera: ${e.description}')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Ambil Foto Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_camera_rounded),
            onPressed: _switchCamera,
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildCameraPreview(),
          Positioned(
            bottom: 20, // Ubah ke 20 untuk lebih turun
            left: 0,
            right: 0,
            child: Center(
              child: _buildCustomFloatingActionButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (!_isInitialized || _cameraController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _cameraController!.value.previewSize!.height,
              height: _cameraController!.value.previewSize!.width,
              child: CameraPreview(_cameraController!),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomFloatingActionButton() {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _buttonScale = 0.9;
        });
      },
      onTapUp: (_) {
        setState(() {
          _buttonScale = 1.0;
        });
        _takePicture();
      },
      onTapCancel: () {
        setState(() {
          _buttonScale = 1.0;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(_buttonScale),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.black,
          size: 35,
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    if (!_isInitialized || _cameraController == null) return;

    try {
      final image = await _cameraController!.takePicture();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Display the Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 100),
            IconButton(
              icon: const Icon(Icons.check_circle,
                  color: Color.fromARGB(255, 255, 255, 255), size: 80),
              onPressed: () {
                // Logika untuk mengonfirmasi foto sebagai profil
                print('Foto dijadikan profil: $imagePath');
                Navigator.of(context)
                    .pop(); // Kembali ke layar sebelumnya setelah konfirmasi
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
        await _cameraController?.dispose();
      } catch (e) {
        print('Error stopping camera: $e');
      }

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

        if (mounted) {
          setState(() {
            _cameraController = newController;
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
            bottom: 20, // Posisi tombol lebih rendah
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
        child: CameraPreview(_cameraController!),
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
      Navigator.pop(context, image);
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}
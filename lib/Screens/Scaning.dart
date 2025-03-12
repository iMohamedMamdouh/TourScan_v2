import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ScanningPage extends StatefulWidget {
  const ScanningPage({super.key});

  @override
  _ScanningPageState createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  File? _image;
  Interpreter? _interpreter;
  List<String> _labels = [];
  final double _confidenceThreshold = 60.0;
  final List<String> _results = []; // Store multiple results

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model/model.tflite');
      print("✅ Model Loaded Successfully");
      loadLabels();
    } catch (e) {
      print("❌ Error Loading Model: $e");
    }
  }

  Future<void> loadLabels() async {
    try {
      String labelsData = await DefaultAssetBundle.of(context)
          .loadString('assets/model/labels.txt');
      setState(() {
        _labels =
            labelsData.split('\n').where((label) => label.isNotEmpty).toList();
      });
      print("✅ Labels Loaded: ${_labels.length}");
    } catch (e) {
      print("❌ Error Loading Labels: $e");
    }
  }

  Future<List<List<List<double>>>> preprocessImage(File imageFile) async {
    final img.Image? image = img.decodeImage(await imageFile.readAsBytes());

    if (image == null) {
      throw Exception("❌ Failed to decode image");
    }

    final img.Image resized = img.copyResize(image, width: 224, height: 224);

    List<List<List<double>>> input = List.generate(
      224,
      (y) => List.generate(
        224,
        (x) {
          final img.Pixel pixel = resized.getPixelSafe(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        },
      ),
    );

    return input;
  }

  Future<void> classifyImage(File image) async {
    if (_interpreter == null || _labels.isEmpty) {
      print("❌ Model not loaded yet!");
      return;
    }

    List<List<List<double>>> inputImage = await preprocessImage(image);
    List<List<double>> output =
        List.generate(1, (_) => List.filled(_labels.length, 0));

    _interpreter!.run([inputImage], output);

    int maxIndex = output[0]
        .indexWhere((val) => val == output[0].reduce((a, b) => a > b ? a : b));
    double confidence = output[0][maxIndex] * 100;

    setState(() {
      _results.clear(); // Clear previous results
      if (confidence >= _confidenceThreshold) {
        _results.add(
            "Detected: ${_labels[maxIndex]} (${confidence.toStringAsFixed(2)}%)");
      } else {
        _results.add("❌ Statue not recognized.");
      }
    });

    print("📸 Classification Result: ${_results.first}");
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _results.clear(); // Clear previous results
      });
      classifyImage(_image!);
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF582218),
        title: const Padding(
          padding: EdgeInsets.only(right: 48),
          child: Center(
            child: Text(
              "Statue Recognition",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: _image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image, size: 150, color: Color(0xFF582218)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera, color: Colors.white),
                        label: const Text("Capture Image",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF582218)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () => pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.image, color: Colors.white),
                        label: const Text("Pick from Gallery",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF582218)),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  const SizedBox(height: 20),
                  // Image with border radius
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(16), // Apply border radius
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Scrollable ListView for classification results
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: _results[index].contains("Detected:")
                                ? const Icon(Icons.check_circle,
                                    color: Colors.green)
                                : null, // Hide icon if not recognized
                            title: Text(
                              _results[index],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera, color: Colors.white),
                        label: const Text("Capture Image",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF582218)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () => pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.image, color: Colors.white),
                        label: const Text("Pick from Gallery",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF582218)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}

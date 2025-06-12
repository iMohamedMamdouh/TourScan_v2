import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechButton extends StatefulWidget {
  final String text;
  final Color iconColor;

  const TextToSpeechButton({
    super.key,
    required this.text,
    this.iconColor = const Color(0xFF582218),
  });

  @override
  State<TextToSpeechButton> createState() => _TextToSpeechButtonState();
}

class _TextToSpeechButtonState extends State<TextToSpeechButton> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(widget.text);
    setState(() {
      isSpeaking = true;
    });
  }

  Future<void> _stop() async {
    await flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up,
          color: widget.iconColor),
      onPressed: () {
        isSpeaking ? _stop() : _speak();
      },
    );
  }
}

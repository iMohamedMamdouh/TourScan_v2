import 'dart:convert';

import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = 'AIzaSyARr7AzYiQ1u1jA8wzDIUrBo7Z7-jNKgPM';

  Future<String> sendMessage(String userInput) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=$apiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": userInput},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final responseText = json['candidates'][0]['content']['parts'][0]['text'];
      return responseText;
    } else {
      throw Exception('Failed to get response: ${response.body}');
    }
  }
}

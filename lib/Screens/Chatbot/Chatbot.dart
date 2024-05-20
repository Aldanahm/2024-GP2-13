import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Message {
  final String sender;
  final String content;

  Message({required this.sender, required this.content});
}

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<Chatbot> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/images/JoyRB.png',
                width: 40,
                height: 40,
              ),
            ),
            Text(
              'Joy',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF694F79),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(184, 162, 185, 0.05),
        centerTitle:
            false, // Set to false to align the logo and text to the left
        iconTheme: const IconThemeData(
          color: Color(0xFF694F79),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(Message message) {
    CrossAxisAlignment alignment = message.sender == 'You'
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    Color bubbleColor = message.sender == 'You'
        ? const Color.fromARGB(255, 243, 240, 245)
        : const Color.fromRGBO(184, 162, 185, 0.2);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        message.sender == 'You' ? 90.0 : 9.0, // Left padding for user messages
        8.0, // Top padding
        message.sender != 'You'
            ? 90.0
            : 0.0, // Right padding for chatbot messages
        8.0, // Bottom padding
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.sender !=
              'You') // Add image to the left of chatbot message box
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/images/JoyRB.png',
                width: 40,
                height: 40,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.sender !=
                          'You') // Add 'Joy' label for chatbot message
                        Text(
                          'Joy',
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.bold),
                        ),
                      Text(message.content, style: GoogleFonts.nunito()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (message.sender ==
              'You') // Add image to the right of user message box
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 40,
                height: 40,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: const Color(0xFF694F79),
            onPressed: () {
              _sendMessage(_textController.text);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String text) async {
    _addMessage('You', text);

    // Simulate Joy's response
    var botResponse = await _getBotResponse(text);

    // Check if the bot's response starts with "Joy:"
    if (botResponse.startsWith('*Joy:*')) {
      // Remove "Joy:" from the beginning of the response
      botResponse = botResponse.substring(8);
    }

    _addMessage('Joy', botResponse);
  }

  Future<String> _getBotResponse(String input) async {
    const apiKey = "AIzaSyAxTy88lq80na2Rd9aiPlASCQgix6vwzOA"; // My API key
    const apiUrl =
        "https://generativelanguage.googleapis.com/v1beta3/models/text-bison-001:generateText?key=$apiKey"; //URL to GenerativeAi

    final predefinedPrompt = """
      You are a virtual friend named Joy targeting people in need of a friend.
      Create encouraging and funny messages that may have emojis. Keep copy under a few sentences long.

      input: $input
      output:
    """;

    final requestBody = json.encode({
      "prompt": {
        "text": predefinedPrompt,
      },
      "temperature": 0.7,
      "top_k": 40,
      "top_p": 0.95,
      "candidate_count": 1,
      "max_output_tokens": 1024,
      "stop_sequences": [],
      "safety_settings": [
        {"category": "HARM_CATEGORY_DEROGATORY", "threshold": 1},
        {"category": "HARM_CATEGORY_TOXICITY", "threshold": 1},
        {"category": "HARM_CATEGORY_VIOLENCE", "threshold": 2},
        {"category": "HARM_CATEGORY_SEXUAL", "threshold": 2},
        {"category": "HARM_CATEGORY_MEDICAL", "threshold": 2},
        {"category": "HARM_CATEGORY_DANGEROUS", "threshold": 2}
      ]
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("API Response: $jsonResponse");

        final candidates = jsonResponse?["candidates"];
        if (candidates != null && candidates.isNotEmpty) {
          final output = candidates[0]["output"];
          if (output != null) {
            return output;
          } else {
            throw Exception("Invalid response structure");
          }
        } else {
          throw Exception("No candidates in the response");
        }
      } else {
        throw Exception(
            "Failed to get bot response. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in _getBotResponse: $error");
      return "Failed to get bot response";
    }
  }

  void _addMessage(String sender, String content) {
    Message message = Message(sender: sender, content: content);
    setState(() {
      _messages.add(message);
    });

    _textController.clear();
  }
}
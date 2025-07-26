import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'scanner.dart';
import 'get_started.dart';
import 'profile_page.dart';
import 'dashboard.dart';
import 'services/auth_service.dart'; // 🔸 Import AuthService

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _chatHistory = [];
  bool _isTyping = false;

  Future<void> _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _chatHistory.add({'role': 'user', 'content': input});
      _isTyping = true;
      _controller.clear();
    });

    await _scrollToBottom();

    String finalPrompt = input;

    final isFollowUp =
        RegExp(r'^(summarize|summarise|what|how|this|that|can|do|is|are|should|could|would|if|which)',
                    caseSensitive: false)
                .hasMatch(input) ||
            input.split(' ').length <= 5;

    if (isFollowUp && _chatHistory.length >= 2) {
      final lastUserMsg = _chatHistory.reversed.firstWhere(
          (msg) => msg['role'] == 'user' && msg['content'] != input)['content'];
      final lastBotResponse = _chatHistory.reversed
          .firstWhere((msg) => msg['role'] == 'assistant')['content'];

      finalPrompt =
          "This is a follow-up question. Prior content:\nUser: $lastUserMsg\nAssistant: $lastBotResponse\nFollow-up: $input";
    }

    try {
      // 🔸 Fetch token before making the request
      final token = await AuthService.getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Could not get auth token")),
        );
        setState(() => _isTyping = false);
        return;
      }

      final uri = Uri.parse(
          "https://nutrigen-546561582790.asia-south1.run.app/api/ask-llm");
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 🔐 Add token in header
        },
        body: jsonEncode({'query': finalPrompt}),
      );

      print('📬 Status Code: ${response.statusCode}');
      print('📨 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        final aiReply = decoded['answer'];

        setState(() {
          _chatHistory.add({'role': 'assistant', 'content': aiReply});
          _isTyping = false;
        });
      } else {
        setState(() {
          _chatHistory.add({
            'role': 'assistant',
            'content': '⚠ Failed to get a response. Try again.'
          });
          _isTyping = false;
        });
      }
    } catch (e) {
      setState(() {
        _chatHistory
            .add({'role': 'assistant', 'content': '⚠ Error connecting to AI.'});
        _isTyping = false;
      });
    }

    await _scrollToBottom();
  }

  Future<void> _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _buildMessageBubble(String message, bool isUser) {
    final bubbleColor =
        isUser ? Colors.white : const Color.fromARGB(255, 205, 243, 187);
    final textColor =
        isUser ? Colors.black87 : const Color.fromARGB(255, 0, 0, 0);
    final border = isUser ? Border.all(color: Colors.grey.shade300) : null;

    final radius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isUser ? 16 : 0),
      bottomRight: Radius.circular(isUser ? 0 : 16),
    );

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: radius,
          border: border,
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 15.5, color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Ask AI'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF4CAF50),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Get instant answers about food, diets, and nutrition',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatHistory.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _chatHistory.length) {
                  return _buildMessageBubble("AI is typing...", false);
                }
                final msg = _chatHistory[index];
                return _buildMessageBubble(
                    msg['content']!, msg['role'] == 'user');
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration.collapsed(
                      hintText:
                          'Ask something like "Is oat milk keto-friendly?"',
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF4CAF50)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 76, 175, 80),
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home,
                    size: 28, color: Color.fromARGB(255, 246, 246, 246)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.restaurant_menu_outlined, size: 26),
                color: const Color.fromARGB(255, 246, 246, 246),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.qr_code_scanner, size: 30),
                color: const Color.fromARGB(255, 246, 246, 246),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BarcodeScannerPage()),
                  );
                },
              ),
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.chat_bubble_outline,
                      size: 26, color: Color(0xFF4CAF50)),
                  onPressed: () {},
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, size: 28),
                color: const Color.fromARGB(255, 246, 246, 246),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GetStartedPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

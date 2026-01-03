import 'package:flutter/material.dart';
import 'package:untitled/app_theme.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'sender': 'bot', 'text': 'مرحباً بك! أنا مساعد KIT الذكي. كيف يمكنني مساعدتك اليوم؟'},
  ];
  Future<String> _getAIResponse(String userMessage) async {
    try {
      // استخدمي مفتاح الـ API الذي استخرجتيه من مشروع kitSpace
      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: 'AIzaSyAxFciPAIhIbWnW2zLCeEjj0gwE5uKzsIw',
      );

      final content = [Content.text(userMessage)];
      final response = await model.generateContent(content);

      if (response.text != null) {
        return response.text!;
      } else {
        return "عذراً، لم يتوفر رد من الذكاء الاصطناعي.";
      }
    } catch (e) {
      // هذا السطر سيخبرنا في الـ Console بالسبب الدقيق (مثلاً: مفتاح خاطئ أو خدمة غير مفعلة)
      print("---------------- DEBUG ERROR ----------------");
      print(e);
      print("---------------------------------------------");

      return "حدث خطأ: تأكدي من تفعيل الـ API وتحديث المكتبة.";
    }
  }
  // --- التعامل مع إرسال الرسائل ---
  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    _textController.clear();

    setState(() {
      _messages.add({'sender': 'user', 'text': text}); // رسالة المستخدم
      _messages.add({'sender': 'bot', 'text': 'جاري التفكير...'}); // رسالة انتظار
    });

    String aiResponse = await _getAIResponse(text);

    setState(() {
      _messages[_messages.length - 1] = {'sender': 'bot', 'text': aiResponse}; // استبدال رسالة الانتظار
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KIT Chatbot'),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          const Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, String> message) {
    final bool isBot = message['sender'] == 'bot';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBot) _botAvatar(),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isBot ? Colors.grey[200] : AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15).copyWith(
                  bottomLeft: isBot ? const Radius.circular(0) : const Radius.circular(15),
                  bottomRight: isBot ? const Radius.circular(15) : const Radius.circular(0),
                ),
              ),
              child: Text(
                message['text']!,
                style: TextStyle(color: isBot ? Colors.black87 : Colors.white),
              ),
            ),
          ),
          if (!isBot) _userAvatar(),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(hintText: 'أرسل رسالة...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppTheme.primaryColor),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  Widget _botAvatar() {
    return const Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.psychology, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _userAvatar() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(Icons.person, color: Colors.white, size: 20),
      ),
    );
  }
}

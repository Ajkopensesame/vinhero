import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.question),
                  subtitle: Text(message.answer),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _addMessage(_controller.text);
                  _controller.clear();
                },
              ),
              title: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter a question',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addMessage(String question) {
    final answer = _getAnswer(question);
    final message = ChatMessage(question: question, answer: answer);
    setState(() {
      _messages.insert(0, message);
    });
  }

  String _getAnswer(String question) {
    // TODO: Replace with actual logic to get answer based on question
    return 'I do not understand the question';
  }
}

class ChatMessage {
  final String question;
  final String answer;

  ChatMessage({required this.question, required this.answer});
}

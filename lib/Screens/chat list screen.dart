import 'package:flutter/material.dart';
import 'package:tourscan/features/chatBot/presentation/chat_bot_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Map<String, String>> chats = [
    {"name": "Alice", "lastMessage": "Hey! How are you?"},
    {"name": "Bob", "lastMessage": "Let's meet tomorrow."},
    {"name": "Charlie", "lastMessage": "Did you finish the project?"},
    {"name": "David", "lastMessage": "Happy Birthday!"},
    {"name": "Foda", "lastMessage": "Let's meet tomorrow."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF582218),
        title: const Text(
          'Chats',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chats[index]["name"]!,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              chats[index]["lastMessage"]!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF582218),
              child: Text(
                chats[index]["name"]![0].toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ChatScreen(
              //           currentUser: 'alic',
              //           chatPartner: 'Bebo')), // تمرير اسم المستخدم
              // );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatBotScreen()));
        },
        backgroundColor: const Color(0xFF582218),
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}

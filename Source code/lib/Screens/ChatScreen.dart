import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/generated/l10n.dart';
import 'package:tourscan/utils/animation_utils.dart';

class ChatScreen extends StatefulWidget {
  final String currentUser;
  final String chatPartner;

  const ChatScreen(
      {super.key, required this.currentUser, required this.chatPartner});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final CollectionReference _messages;
  final List<Map<String, dynamic>> _fixedMessages = [
    {
      'text': 'Hello!',
      'sender': 'other',
      'isFixed': true,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'text': 'Where is Tutankhamun?',
      'sender': 'other',
      'isFixed': true,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 4)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _messages = FirebaseFirestore.instance
        .collection('chats')
        .doc(_getChatId())
        .collection('messages');
  }

  String _getChatId() {
    List<String> users = [widget.currentUser, widget.chatPartner];
    users.sort();
    return users.join('_');
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      _messages.add({
        'text': _controller.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'sender': widget.currentUser,
      }).then((_) {
        print("Message sent successfully!");
      }).catchError((error) {
        print("Error sending message: $error");
      });

      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessageBubble(Map<String, dynamic> messageData, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF582218) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          messageData['text'] ?? '',
          style: TextStyle(
            color: isMe ? Colors.white : const Color(0xFF424242),
            fontSize: 16,
          ),
        ),
      ),
    ).slideIn(
      duration: const Duration(milliseconds: 300),
      direction: isMe ? SlideDirection.right : SlideDirection.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: Text(
          widget.chatPartner,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _messages.orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                List<Map<String, dynamic>> allMessages = [];

                // Add fixed messages first
                allMessages.addAll(_fixedMessages);

                // Add Firebase messages if available
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  for (var doc in snapshot.data!.docs.reversed) {
                    allMessages.add({
                      'text': doc['text'],
                      'sender': doc['sender'],
                      'createdAt': doc['createdAt'],
                      'isFixed': false,
                    });
                  }
                }

                if (snapshot.connectionState == ConnectionState.waiting &&
                    allMessages.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  );
                }

                if (allMessages.isEmpty) {
                  return const Center(child: Text("No messages yet"));
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: allMessages.length,
                  itemBuilder: (context, index) {
                    var messageData = allMessages[index];
                    bool isMe = messageData['sender'] == widget.currentUser;

                    return _buildMessageBubble(messageData, isMe);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            "assets/Link.svg",
                            width: 24,
                            height: 24,
                          ),
                        ),
                        hintText: S.of(context).Enteryourmessage,
                        hintStyle: const TextStyle(color: Color(0xffD1D1D1)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xff582218),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      S.of(context).sendIcon,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ).slideIn(
              delay: const Duration(milliseconds: 500),
              direction: SlideDirection.bottom,
            ),
          ),
        ],
      ),
    );
  }
}

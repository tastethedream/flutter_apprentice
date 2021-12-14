import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/message.dart';
import '../data/message_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_widget.dart';
import '../data/user_dao.dart';



class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // TODO: Add Email String
  String? email;


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());
    // TODO: Add MessageDao
    final messageDao = Provider.of<MessageDao>(context, listen: false);


    // TODO: Add UserDao
    final userDao = Provider.of<UserDao>(context, listen: false);
    email = userDao.email();


    return Scaffold(
      appBar: AppBar(
        title: const Text('RayChat'),
        // TODO: Replace with actions
        actions: [
          IconButton(
            onPressed: () {
              userDao.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TODO: Add Message DAO to _getMessageList
            _getMessageList(messageDao),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _messageController,
                      onSubmitted: (input) {
                        // TODO: Add Message DAO 1
                        _sendMessage(messageDao);

                      },
                      decoration:
                          const InputDecoration(hintText: 'Enter new message'),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(_canSendMessage()
                        ? CupertinoIcons.arrow_right_circle_fill
                        : CupertinoIcons.arrow_right_circle),
                    onPressed: () {
                      // TODO: Add Message DAO 2
                      _sendMessage(messageDao);

                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Replace _sendMessage
  void _sendMessage(MessageDao messageDao) {
    if (_canSendMessage()) {
      final message = Message(
        text: _messageController.text,
        date: DateTime.now(),
        // TODO: add email
        email: email,

      );
      messageDao.saveMessage(message);
      _messageController.clear();
      setState(() {});
    }
  }


  // TODO: Replace _getMessageList
  Widget _getMessageList(MessageDao messageDao) {
    return Expanded(
      // 1
      child: StreamBuilder<QuerySnapshot>(
        // 2
        stream: messageDao.getMessageStream(),
        // 3
        builder: (context, snapshot) {
          // 4
          if (!snapshot.hasData)
            return const Center(child: LinearProgressIndicator());

          // 5
          return _buildList(context, snapshot.data!.docs);
        },
      ),
    );
  }


  // TODO: Add _buildList
  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    // 1
    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20.0),
      // 2
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }



  // TODO: Add _buildListItem
  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    // 1
    final message = Message.fromSnapshot(snapshot);
    // 2
    return MessageWidget(
        message.text,
        message.date,
        message.email
    );
  }


  bool _canSendMessage() => _messageController.text.length > 0;

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

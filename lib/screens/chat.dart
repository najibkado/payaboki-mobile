import 'package:flutter/material.dart';
import 'package:payaboki/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  late String messageText;

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
  }

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser();
  //     if (user != null) {
  //       loggedInUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

////  void getMessages() async {
////    try {
////      final messages = await _firestore.collection('messages').getDocuments();
////      for (var message in messages.documents) {
////        print(message.data);
////      }
////    } catch (e) {
////      print(e);
////    }
////  }
//
//  void messagesStream() async {
//    await for (var snapshot in _firestore.collection('messages').snapshots()) {
//      for (var message in snapshot.documents) {
//        print(message.data);
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Dispute Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //TODO: Get Message Streams
            // MessagesStream(),
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                      "Dispute resolution for XFTRWQYWTEYSAUB transaction"),
                )),
            Expanded(
              flex: 10,
              child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: [
                  MessageBubble(
                      sender: "najibkado@gmail.com",
                      text: "Sample test",
                      isMe: true),
                  MessageBubble(
                      sender: "customer care",
                      text: "Sample test",
                      isMe: false),
                  MessageBubble(
                      sender: "najibkado@gmail.com",
                      text: "Sample test",
                      isMe: true),
                  MessageBubble(
                      sender: "najibkado@gmail.com",
                      text: "Sample test",
                      isMe: true),
                  MessageBubble(
                      sender: "najibkado@gmail.com",
                      text: "Sample test",
                      isMe: true),
                  MessageBubble(
                      sender: "customer care",
                      text: "Sample test",
                      isMe: false),
                  MessageBubble(
                      sender: "najibkado@gmail.com",
                      text: "Sample test",
                      isMe: true),
                  MessageBubble(
                      sender: "customer care",
                      text: "Sample test",
                      isMe: false),
                  MessageBubble(
                      sender: "najibkado@gmail.com",
                      text: "Sample test",
                      isMe: true),
                  MessageBubble(
                      sender: "customer care",
                      text: "Sample test",
                      isMe: false),
                ],
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //messageText
                      messageTextController.clear();
                      // _firestore.collection('messages').add({
                      //   'sender': loggedInUser.email,
                      //   'text': messageText,
                      // });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MessagesStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('messages').snapshots(),
//       // ignore: missing_return
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         final messages = snapshot.data.documents.reversed;
//         List<MessageBubble> messageBubbles = [];
//         for (var message in messages) {
//           final messageText = message.data['text'];
//           final messageSender = message.data['sender'];
//
//           final currentUser = loggedInUser.email;
//
//           final messageBubble = MessageBubble(
//             sender: messageSender,
//             text: messageText,
//             isMe: currentUser == messageSender,
//           );
//           messageBubbles.add(messageBubble);
//         }
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//             children: messageBubbles,
//           ),
//         );
//       },
//     );
//   }
// }

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          SizedBox(
            height: 2.0,
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15.0, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

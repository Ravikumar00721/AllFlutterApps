import 'package:chatapp_ravikumar/Models/chatroommodel.dart';
import 'package:flutter/material.dart';
import 'package:chatapp_ravikumar/Models/usermodels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatRoom;
  final UserModel userModel;
  final User firebaseuser;

  const ChatRoomScreen({
    Key? key,
    required this.targetUser,
    required this.chatRoom,
    required this.userModel,
    required this.firebaseuser,
  }) : super(key: key);

  @override
  _ChatRoomScreen createState() => _ChatRoomScreen();
}

class _ChatRoomScreen extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Function to send a message
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> messageData = {
        "senderId": widget.userModel.uid,
        "receiverId": widget.targetUser.uid,
        "message": _messageController.text,
        "timestamp": FieldValue.serverTimestamp(),
      };

      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomid)
          .collection("messages")
          .add(messageData)
          .then((value) {
        FirebaseFirestore.instance
            .collection("chatrooms")
            .doc(widget.chatRoom.chatroomid)
            .update({"lastmessage": _messageController.text});
        _messageController.clear();
      }).catchError((error) {
        print("Failed to send message: $error");
      });
    }
  }

  // Function to delete a message
  Future<void> _deleteMessage(String messageId) async {
    await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(widget.chatRoom.chatroomid)
        .collection("messages")
        .doc(messageId)
        .delete();

    // Optionally update the last message here if required
  }

  // Function to edit a message
  Future<void> _editMessage(String messageId, String currentText) async {
    TextEditingController editController = TextEditingController(text: currentText);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Message"),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: "Enter new message"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (editController.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection("chatrooms")
                      .doc(widget.chatRoom.chatroomid)
                      .collection("messages")
                      .doc(messageId)
                      .update({"message": editController.text});

                  // Update last message if this is the latest one
                  FirebaseFirestore.instance
                      .collection("chatrooms")
                      .doc(widget.chatRoom.chatroomid)
                      .update({"lastmessage": editController.text});

                  Navigator.of(context).pop();
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.targetUser.name}"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("chatrooms")
                    .doc(widget.chatRoom.chatroomid)
                    .collection("messages")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No messages yet."));
                  }

                  List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var messageData = messages[index].data() as Map<String, dynamic>;
                      bool isMe = messageData['senderId'] == widget.userModel.uid;
                      String messageId = messages[index].id;

                      return GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                    onTap: () {
                                      _deleteMessage(messageId);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _editMessage(messageId, messageData['message']);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: isMe ? Colors.teal[200] : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                messageData['message'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.teal),
                    onPressed: _sendMessage,
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

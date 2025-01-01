import 'package:chatapp_ravikumar/Models/chatroommodel.dart';
import 'package:chatapp_ravikumar/Screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp_ravikumar/Models/usermodels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp_ravikumar/Screens/chatroompage.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class HomeScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;

  const HomeScreen(
      {Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    try {
      print("User From Home UID");
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("chatrooms")
          .where("participants.${widget.userModel.uid}", isEqualTo: true)
          .where("participants.${targetUser.uid}", isEqualTo: true)
          .get();

      if (snapshot.docs.isNotEmpty) {
        print("Chat Room already exists");
        Map<String, dynamic> chatRoomData =
            snapshot.docs[0].data() as Map<String, dynamic>;
        return ChatRoomModel.fromMap(chatRoomData);
      } else {
        print("Creating a new chat room");
        ChatRoomModel newChatRoom = ChatRoomModel(
          chatroomid: uuid.v1(),
          participants: {
            widget.userModel.uid.toString(): true,
            targetUser.uid.toString(): true,
          },
          lastmessage: "",
        );
        await FirebaseFirestore.instance
            .collection("chatrooms")
            .doc(newChatRoom.chatroomid)
            .set(newChatRoom.toMap());
        return newChatRoom;
      }
    } catch (e) {
      print("Error fetching chat room: $e");
      return null;
    }
  }

  Future<String> getLastMessage(UserModel targetUser) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("chatrooms")
          .where("participants.${widget.userModel.uid}", isEqualTo: true)
          .where("participants.${targetUser.uid}", isEqualTo: true)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> chatRoomData =
            snapshot.docs[0].data() as Map<String, dynamic>;
        String lastMessage = chatRoomData['lastmessage'] ?? "";
        return lastMessage.isEmpty
            ? "Say hi to ${targetUser.name}"
            : lastMessage;
      }
      return "Say hi to ${targetUser.name}";
    } catch (e) {
      print("Error fetching last message: $e");
      return "Error fetching message.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5.0,
        backgroundColor: Colors.teal,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              "Home",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              } catch (e) {
                print("Error signing out: $e");
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Error signing out")));
              }
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No users found"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var userDoc = snapshot.data!.docs[index];

                var userName = userDoc['name'] ?? "Unnamed User";
                var userUID = userDoc['uid'] ?? "Unknown UID"; // Add this line

                // Debug print the uid
                print("User From Home UID: $userUID");

                // Handle cases where UID might be missing
                if (userUID == "Unknown UID") {
                  return SizedBox.shrink();
                }

                var targetUser = UserModel(
                  uid: userUID,
                  name: userName,
                );

                if (userUID == widget.userModel.uid) {
                  return SizedBox.shrink();
                }

                return FutureBuilder<String>(
                  future: getLastMessage(targetUser),
                  builder: (context, lastMessageSnapshot) {
                    String lastMessage = "Say hi to ${targetUser.name}";
                    if (lastMessageSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      lastMessage = "Loading...";
                    } else if (lastMessageSnapshot.hasData) {
                      lastMessage = lastMessageSnapshot.data!;
                    }

                    return GestureDetector(
                      onTap: () async {
                        try {
                          ChatRoomModel? chatRoom =
                              await getChatRoomModel(targetUser);
                          if (chatRoom != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatRoomScreen(
                                  chatRoom: chatRoom,
                                  userModel: widget.userModel,
                                  firebaseuser: widget.firebaseuser,
                                  targetUser: targetUser,
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          print("Error navigating to chat room: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error creating chat room")),
                          );
                        }
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(Icons.person, color: Colors.teal),
                        ),
                        title: Text(
                          userName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(lastMessage),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

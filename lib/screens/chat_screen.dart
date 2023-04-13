import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Screen"),
        actions: [
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(value: 'logout',child:
              Row(
                children: const [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8,),
                  Text("Logout")
                ],
              ),
              )
            ],
            onChanged: (itemIdentifier){
              if(itemIdentifier=='logout'){
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data?.docs;
          return ListView.builder(
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents?[index]['text']),
            ),
            itemCount: documents?.length,
          );
        },
        stream: FirebaseFirestore.instance
            .collection('chats/7UHs5ZpjlzYFNM778lbl/messages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/7UHs5ZpjlzYFNM778lbl/messages')
              .add({'text': 'Button is clicked'});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

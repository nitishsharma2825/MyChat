import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder:(context,userSnapshots)=>userSnapshots.connectionState==ConnectionState.waiting?
      CircularProgressIndicator() :
      StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdTime', descending: true)
              .snapshots(),
          builder: (context, chatSnapshots) {
            if (chatSnapshots.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final chat = chatSnapshots.data.documents;
            return ListView.builder(
                reverse: true,
                itemCount: chat.length,
                itemBuilder: (context, i) {
                  return MessageBubble(chat[i]['text'],chat[i]['userId']==userSnapshots.data.uid?true:false,key: ValueKey(chat[i].documentID),);
                });
          }),
    );
  }
}

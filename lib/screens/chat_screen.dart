import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat/widgets/chat/messages.dart';
import 'package:my_chat/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyChat'),
          actions: <Widget>[
            DropdownButton(
              icon: Icon(Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                    child: Container(
                  child: Row(
                    children: <Widget>[
                      Text('Logout'),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.exit_to_app)
                    ],
                  ),
                ))
              ],
              onChanged: (identifier){
                if(identifier=='logout'){
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Messages()),
              NewMessage()
            ],
          ),
        ),
    );
  }
}

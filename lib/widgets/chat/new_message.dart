import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _typedText;
  final textController = TextEditingController();

  void _submitMessage() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chat').add({
      'text':_typedText,
      'createdTime':Timestamp.now(),
      'userId':currentUser.uid
    });
    textController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Type a message...'),
              onChanged: (value) {
                setState(() {
                  _typedText = value;
                });
              },
            ),
          ),
          IconButton(icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _typedText==null?null : _submitMessage,)
        ],
      ),
    );
  }
}

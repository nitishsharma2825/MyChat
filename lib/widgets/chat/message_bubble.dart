import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message,this.isMe,{this.key});
  final String message;
  bool isMe;
  final Key key;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
      children:[Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: isMe?Radius.circular(12):Radius.circular(0),
            topRight: isMe?Radius.circular(0):Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12)
          ),
          color: isMe?Theme.of(context).accentColor:Colors.grey[300],
        ),
        width:140,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4
        ),
        child: Text(message,style: TextStyle(color:isMe?Theme.of(context).accentTextTheme.headline6.color:Colors.black),),
      ),]
    );
  }
}

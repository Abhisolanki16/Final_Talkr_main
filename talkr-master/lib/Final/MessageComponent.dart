import 'package:flutter/material.dart';
import 'Message.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({ Key? key, this.msg }) : super(key: key);
  final Message? msg;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var date = msg!.createdAt!.toDate().toLocal();
    return Row(
      mainAxisAlignment: msg!.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: msg!.isMe ? Colors.blue : Colors.black.withOpacity(.7),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: msg!.isMe ? const Radius.circular(10) : const Radius.circular(0),
                bottomRight: msg!.isMe ? const Radius.circular(0) : const Radius.circular(10),
              ), 
            ),
            constraints: BoxConstraints(
              minHeight: 40,minWidth: 30,maxWidth: width /1.1
            ),
            child: Text(
              msg!.content!,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Container(
            //     padding: EdgeInsets.only(right: 5,bottom: 5),
            //     child: Text(
            //       '${date.hour}h${date.minute}',
            //       style: TextStyle(fontSize: 10,color: Colors.white),
            //     ),
            //   ),
            // ),
          ],           
        )
      ]
    );
  }
}
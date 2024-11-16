import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {},
// Suggested code may be subject to a license. Learn more: ~LicenseLog:146365486.
          child: const ListTile(
            leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
            title: Text('Demo Person'),
            subtitle: Text('Last user message', maxLines: 1),
            trailing: Text('12:00 PM'),
          ),
        ));
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_socket_channel/status.dart' as status;

class ChatRoomScreen extends StatefulWidget {
  final String title;
  final Uri uri;

  ChatRoomScreen({Key? key, required this.title, required this.uri})
      : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late IOWebSocketChannel channel;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(widget.uri);
    log(channel.sink.toString());

    channel.sink.add(jsonEncode({
      "type": "ENTER",
      "roomId": "10e07fa1-f72e-45ba-b056-cd5f7e1633fe",
      "sender": "한영찬2",
      "message": ""
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                Map<String, dynamic> data =
                    jsonDecode(snapshot.data.toString());
                log(data.toString());
                return Text(snapshot.hasData
                    ? '${data['sender']} : ${data['message']}'
                    : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      log(_controller.text);
      channel.sink.add({
        "type": "TALK",
        "roomId": "10e07fa1-f72e-45ba-b056-cd5f7e1633fe",
        "sender": "한영찬",
        "message": _controller.text
      });
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _chatStream = FirebaseFirestore.instance
      .collection('chat')
      .orderBy('date', descending: false)
      .snapshots();
  final _chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: _chatStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(data.docs[index]['chat']),
                        );
                      },
                      itemCount: data!.size,
                      // reverse: true,
                    ),
                  );
                } else {
                  return const Text('Error while loading chats....');
                }
              },
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      decoration: InputDecoration(
                        hintText: 'Type a chat....',
                        filled: true,
                        fillColor: Colors.indigo.withOpacity(0.5),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection('chat')
                            .add({
                          'chat': _chatController.text,
                          'date': Timestamp.now(),
                          'userid': FirebaseAuth.instance.currentUser!.uid,
                        });
                        _chatController.clear();
                        FocusScope.of(context).unfocus();
                      } catch (e) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('Error while adding chat'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      }
                    },
                    icon: const Icon(Icons.send_outlined),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

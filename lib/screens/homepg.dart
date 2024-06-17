import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/screens/addnote.dart';
import 'package:notes_app/screens/viewnote.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  List<Color> myColors = [
    Colors.yellow.shade200,
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.deepPurple.shade200,
    Colors.purple.shade200,
    Colors.teal.shade200,
    Colors.pink.shade200,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddNote()))
              .then((value) {
            setState(() {});
          });
          ;
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'NOTES',
          style:
              TextStyle(fontFamily: 'lato', fontSize: 28, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<QuerySnapshot>(
        // Access ref via widget.ref
        future: widget.ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "You have no saved Notes!",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Random random = Random();
                // Access myColors via widget.myColors
                Color bg =
                    widget.myColors[random.nextInt(widget.myColors.length)];
                Map<String, dynamic> data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                DateTime mydateTime = data['created'].toDate();
                String formattedTime = DateFormat('d MMMM').format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data!.docs[index].reference,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    child: Card(
                      elevation: 29,
                      color: bg,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${data['title']}",
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                               ElevatedButton(onPressed: (){
                                  deleteNote(snapshot.data!.docs[index].reference);
                               },
                                style: ElevatedButton.styleFrom( 
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Icon(Icons.delete,
                                size: 29,
                                color: Colors.red[400],)
                              )
                              ],
                            ),
                            const SizedBox(height:10,),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                formattedTime,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "lato",
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                    
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Loading...", style:
              TextStyle(fontFamily: 'lato', fontSize: 28, color: Colors.white),),
            );
          }
        },
      ),
    );
  }
void deleteNote(DocumentReference docRef) async {
    try {
      await docRef.delete();
      ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: Colors.black87,
    duration: const Duration(seconds: 3),
    content: const Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 10),
        Text(
          'Note deleted successfully!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    ),
    action: SnackBarAction(
      label: 'Close',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  ),
);

      setState(() {}); // Update UI after deletion
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete note. Please try again.'),
        ),
      );
    }
  }
}

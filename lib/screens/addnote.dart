import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
   String ?title;
   String ?des;
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                     
                        Navigator.of(context).pop();
                      
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8), // Adjusts the padding inside the button
                      minimumSize: const Size(
                          50, 20), // Sets the minimum size of the button
                      textStyle: const TextStyle(
                          fontSize:
                              12), // Adjusts the text size inside the button
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 24.0,
                    ),
                  ),
          
                    ElevatedButton(
                    onPressed: () {
                      add();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8), // Adjusts the padding inside the button
                      minimumSize: const Size(
                          60, 35), // Sets the minimum size of the button
                      textStyle: const TextStyle(
                          fontSize:
                              12), // Adjusts the text size inside the button
                    ),
                    child: const Text("Save",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'lato'),)
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Title",
                style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 37,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Title"
                ),
                style: const TextStyle(
                            fontSize: 32.0,
                            fontFamily: "lato",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        onChanged: (_val) {
                        title = _val;
                      },
              ),
              const SizedBox(height: 40,),
              const Text(
                "Note description",
                style: TextStyle(
                    fontFamily: 'lato',
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                textAlign: TextAlign.start,
              ),
              
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Note description"
                ),
                style: const TextStyle(
                            fontSize: 22.0,
                            fontFamily: "lato",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        onChanged: (_val) {
                        des = _val;
                      },
              )
            ],
          ),
        ),
      )),
    );
  }
  void add() async {
    // save to db
    

      if(title!=null && des!=null)
      {
          CollectionReference ref = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('notes');

          var data = {
            'title': title,
            'description': des,
            'created': DateTime.now(),
          };
          ref.add(data);
      }
      

    //

    Navigator.pop(context);
  }
}

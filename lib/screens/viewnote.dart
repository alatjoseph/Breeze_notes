import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
    final Map data;
  final String time;
  final DocumentReference ref;

  const ViewNote(this.data, this.time, this.ref);
  

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
   String ?title;
   String ?des;
   bool edit=false;
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext ctx) {
    title=widget.data['title'];
    des=widget.data['description'];
    
    
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
                  if (!edit)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            edit = true; // Enable edit mode
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ), // Adjusts the padding inside the button
                          minimumSize: const Size(
                            60, 35,
                          ), // Sets the minimum size of the button
                          textStyle: const TextStyle(
                            fontSize: 12,
                          ), // Adjusts the text size inside the button
                        ),
                        child: Icon(Icons.edit),
                      )
                    else
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            edit = false; // Disable edit mode
                          });
                          save(); // Save the changes
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ), // Adjusts the padding inside the button
                          minimumSize: const Size(
                            60, 35,
                          ), // Sets the minimum size of the button
                          textStyle: const TextStyle(
                            fontSize: 12,
                          ), // Adjusts the text size inside the button
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lato',
                          ),
                        ),
                      ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  initialValue: widget.data['title'],
                  enabled: edit,
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
                      
                      initialValue: widget.data['description'],
                      enabled: edit,
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
  void save() async {
    if (_formKey.currentState?.validate()??false) {
      // TODo : showing any kind of alert that new changes have been saved
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
  }
}

  
}
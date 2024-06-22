import 'package:flutter/material.dart';
import 'package:notes_app/db_helper/db_helper.dart';
import 'package:notes_app/model/notes_model.dart';

class NotesAddingScreen extends StatefulWidget {
  final Function()? onNoteAdded;
  const NotesAddingScreen({super.key ,this.onNoteAdded});

  @override
  State<NotesAddingScreen> createState() => _NotesAddingScreenState();
}

class _NotesAddingScreenState extends State<NotesAddingScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseHelper? databaseHelper ;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.white),
        title:  Text('Add Notes',style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child:  Column(
            children: [
              TextFormField(
                style:const TextStyle(color: Colors.white),
              controller: titleController,
              decoration: InputDecoration(
                
                hintText: "Write Title",
                hintStyle: Theme.of(context).textTheme.titleSmall,
                border: OutlineInputBorder(
                  borderSide:const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)
                )
              ),
             ),
              const SizedBox(height: 20,),
             TextFormField(
               style:const TextStyle(color: Colors.white),
              controller: descriptionController,
              maxLines: 15,
              decoration: InputDecoration(
                hintText: "Write Description",
                hintStyle: Theme.of(context).textTheme.titleSmall,
                border: OutlineInputBorder(
                  borderSide:const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)
                )
              ),
             ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
  databaseHelper!.insert(
    NotesModel(titleController.text, descriptionController.text)
  ).then((value){
     setState(() {
          // Call the callback function if it's provided
          if (widget.onNoteAdded != null) {
            widget.onNoteAdded!();
          }
          Navigator.pop(context);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notes Added'))
        );
     
  }).onError((error, stackTrace){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.toString()))
    );
  });
      },child: const Text('Add',style: TextStyle(color: Colors.white),),),
    );
  }
}
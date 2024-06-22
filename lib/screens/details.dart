import 'package:flutter/material.dart';

class NotesDetail extends StatefulWidget {
final  String title , description;
  const NotesDetail({super.key , required this.title , required this.description});

  @override
  State<NotesDetail> createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.white),
        title: Text(widget.title,style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(
              child: Text(widget.description,style: Theme.of(context).textTheme.headlineSmall,),
            )
          ],
        ),
      ),
    );
  }
}
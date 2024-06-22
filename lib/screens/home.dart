// ignore_for_file: collection_methods_unrelated_type

import 'package:flutter/material.dart';
import 'package:notes_app/constants/provider.dart';
import 'package:notes_app/constants/theme.dart';
import 'package:notes_app/db_helper/db_helper.dart';
import 'package:notes_app/model/notes_model.dart';
import 'package:notes_app/screens/details.dart';
import 'package:notes_app/screens/notes_add_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController edit1 = TextEditingController();
  TextEditingController edit2 = TextEditingController();
  TextEditingController searchController = TextEditingController();

//=================================
  DatabaseHelper? databaseHelper = DatabaseHelper();
  Future<List<NotesModel>>? dblist;
  loadData() async {
    dblist = databaseHelper!.getNotesList();
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
        actions: [
          Consumer<MyProvider>(builder: (context, value, child) {
            return IconButton(
                onPressed: () {
                  if (value.themeMode == lightTheme) {
                    value.setTheme(darkTheme);
                  } else {
                    value.setTheme(lightTheme);
                  }
                },
                icon: Icon(value.themeMode == lightTheme
                    ? Icons.dark_mode
                    : Icons.light_mode));
          })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: dblist,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: GridView.builder(
                          itemCount: snapshot.data?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: .8,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12),
                          itemBuilder: (context, index) {
                            return Expanded(
                              child: Dismissible(
                                key: ValueKey<int>(snapshot.data![index].id!),
                                direction: DismissDirection.endToStart,
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    databaseHelper!
                                        .delete(snapshot.data![index].id!);
                                    dblist = databaseHelper!.getNotesList();
                                    snapshot.data!
                                        .remove(snapshot.data![index].id!);
                                  });
                                },
                                background: Container(
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NotesDetail(
                                                title: snapshot
                                                    .data![index].title!,
                                                description: snapshot
                                                    .data![index]
                                                    .description!)));
                                  },
                                  child: Material(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                    elevation: 6.0,
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data![index].title!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  title: const Text(
                                                                      'Update'),
                                                                  content:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <Widget>[
                                                                      TextField(
                                                                        controller:
                                                                            edit1,
                                                                        decoration:
                                                                            const InputDecoration(labelText: 'Update Title'),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      TextField(
                                                                        controller:
                                                                            edit2,
                                                                        decoration:
                                                                            const InputDecoration(labelText: 'Update Description'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  actions: <Widget>[
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        databaseHelper!.update(
                                                                          NotesModel(edit1.text, edit2.text,snapshot.data![index].id)
                                                                        ).then((value){
                                                                            setState(() {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                              const  SnackBar(content:  Text('Notes Updated'))
                                                                              );
                                                                             dblist = databaseHelper!.getNotesList();
                                                                            });
                                                                        }).onError((error, stackTrace){

                                                                        })  ; 
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                      child: const Text(
                                                                          'Update'),
                                                                    ),
                                                                  ],
                                                                ));
                                                  },
                                                  icon: const Icon(
                                                      Icons.edit_outlined))
                                            ],
                                          ),
                                          Text(snapshot
                                              .data![index].description!),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ));
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotesAddingScreen(
                        onNoteAdded: () {
                          loadData();
                        },
                      )));
        },
        child: const Text(
          '+',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

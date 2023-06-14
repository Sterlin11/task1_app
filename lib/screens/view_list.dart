import 'package:flutter/material.dart';
import 'package:task1_app/DBhelper/db_connection.dart';
import 'package:task1_app/model/detail.dart';

import '../services/search.dart';
import 'Save_screen.dart';

class ListViewer extends StatefulWidget {
  const ListViewer({super.key});

  @override
  State<ListViewer> createState() => _ListViewerState();
}

class _ListViewerState extends State<ListViewer> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List? detail;
  TextEditingController nameController = TextEditingController();
  TextEditingController luckyNumberController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint("The build has been rebuilt");
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: ItemSearch()),
            icon: const Icon(Icons.search)),
      ]),
      body: FutureBuilder(
        future: _databaseHelper.showAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            detail = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: detail == null ? 0 : detail!.length,
              itemBuilder: (context, index) {
                var list = detail![index];
                // Detail dt = detail![index];
                return Card(
                  color: Colors.black87,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${list['name']} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.deepOrangeAccent),
                            ),
                            Text(
                              "LuckyNumber:${list['luckyNumber']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent),
                            ),
                            Text(
                              "Salary:${list['salary']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          //int id = list['id'];
                          //debugPrint("The id to update is ${list['id']}");
                          await toUpdate(context, list['id']);
                          //debugPrint("updated");
                          setState(() {
                            debugPrint(detail!.toString());
                          });
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.teal,
                      ),
                      IconButton(
                        onPressed: () async {
                          int id = list['id'];
                          debugPrint('$id');

                          await _databaseHelper.delete(id);
                          debugPrint("deleted");

                          setState(() {
                            // debugPrint("The index is $index");
                            // debugPrint("${detail!.length}");
                            // debugPrint("${detail![index]}");

                            //detail!.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SaveDetails();
          }));
        },
        tooltip: "To Save",
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> toUpdate(BuildContext context, int id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: "Name"),
              controller: nameController,
              keyboardType: TextInputType.name,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "LuckyNumber"),
              controller: luckyNumberController,
              keyboardType: TextInputType.phone,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Salary"),
              controller: salaryController,
              keyboardType: TextInputType.phone,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Update'),
                onPressed: () {
                  var name = nameController.text;
                  int luckyNumber = int.parse(luckyNumberController.text);
                  double salary = double.parse(salaryController.text);
                  Detail dt = Detail();
                  dt.name = name;
                  dt.luckyNumber = luckyNumber;
                  dt.salary = salary;
                  _databaseHelper.update(dt, id);
                  // _databaseHelper.update(name, luckyNumber, salary, id);
                  //debugPrint("The id to update is $id");
                  //debugPrint(
                  //   "name:$name,luckyNumber:$luckyNumber,salary:$salary");

                  nameController.clear();
                  luckyNumberController.clear();
                  salaryController.clear();
                  debugPrint(
                      "name:$name,luckyNumber:$luckyNumber,salary:$salary");
                  setState(() {});
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}

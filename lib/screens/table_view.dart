import 'package:flutter/material.dart';
import 'package:task1_app/DBhelper/db_connection.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  List? detail;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    debugPrint("the table build has been rebuilt");
    return Scaffold(
      body: ListView(
        children: [
          Table(
            children: const [
              TableRow(children: [
                Text(
                  "Id",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Text("Name",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                Text("Number",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                Text("Salary",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15))
              ])
            ],
          ),
          FutureBuilder(
            future: dbHelper.showAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                detail = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: detail == null ? 0 : detail!.length,
                  itemBuilder: (context, index) {
                    var list = detail![index];
                    // Detail dt = detail![index];
                    return Table(
                      children: [
                        TableRow(
                          children: [
                            Text(
                              "${list['id']}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${list['name']}"),
                            Text("${list['luckyNumber']}"),
                            Text("${list['salary']}"),
                          ],
                        )
                      ],
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}

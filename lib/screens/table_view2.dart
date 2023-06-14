import 'package:flutter/material.dart';
import 'package:task1_app/DBhelper/db_connection.dart';
import 'package:task1_app/model/detail.dart';

class TableView2 extends StatefulWidget {
  const TableView2({super.key});

  @override
  State<TableView2> createState() => _TableView2State();
}

class _TableView2State extends State<TableView2> {
   List<Detail> detail=[];
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> getDetails() async {
    List<Map<String, dynamic>> listMap = await dbHelper.showAllForTable();
    setState(() {
      for (var map in listMap) {
        detail.add(Detail.fromMap(map));
      }
    });
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

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
          ListView.builder(
            shrinkWrap: true,
            itemCount: detail.length,
            itemBuilder: (context, index) {
              Detail details = detail[index];
              var id = details.id;
              var name = details.name;
              var luckyNumber = details.luckyNumber;
              var salary = details.salary;
              return Table(
                children: [
                  TableRow(
                    children: [
                      Text(
                        "$id",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("$name"),
                      Text("$luckyNumber"),
                      Text("$salary"),
                    ],
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

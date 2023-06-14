import 'package:flutter/material.dart';
import 'package:task1_app/DBhelper/db_connection.dart';
import 'package:task1_app/model/detail.dart';

class ItemSearch extends SearchDelegate {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late List detail;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _databaseHelper.searchDetail(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          detail = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: detail.length,
            itemBuilder: (context, index) {
              var list = detail[index];
              // Detail dt = detail![index];
              return Card(
                child: Row(
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${list['name']} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "LuckyNumber:${list['luckyNumber']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Salary:${list['salary']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                        ],
                      ),
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
    );
  }

  List<Detail> getlist() {
    return detail = _databaseHelper.showAllForTable() as List<Detail>;
  }
}

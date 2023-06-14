class Detail {
  int? id;
  String? name;
  int? luckyNumber;
  double? salary;

  Detail();

  Detail.totable(
      {required salary, required luckyNumber, required name, required id});

  Map<String, dynamic> toMap() {
    return {"name": name, "luckyNumber": luckyNumber, "salary": salary};
  }

  Detail.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    luckyNumber = map['luckyNumber'];
    salary = map['salary'];
  }
}

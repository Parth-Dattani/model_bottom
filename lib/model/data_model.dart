class DataModel {
  int? id;
  String? title;

  DataModel({this.id, this.title});

  DataModel.fromMap(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

// factory DataModel.fromMap(Map<dynamic,dynamic> json){
  //   return DataModel(
  //     id: json['id'],
  //     title: json['title']
  //   );
  // }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = Map<dynamic, dynamic>();
    data['id'] = id;
    data['title'] = title;
    return data;
  }

  Map<String, dynamic> toMap() => {'id': id, 'title': title};
}

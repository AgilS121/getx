class DetailResponseCRUD {
  int? id;
  String? title;
  String? details;
  int? createdBy;

  DetailResponseCRUD({this.id, this.title, this.details, this.createdBy});

  DetailResponseCRUD.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['created_by'] = this.createdBy;
    return data;
  }
}

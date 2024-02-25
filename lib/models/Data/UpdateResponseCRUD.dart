class UpdateResponseCRUD {
  bool? status;
  Task? task;

  UpdateResponseCRUD({this.status, this.task});

  UpdateResponseCRUD.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.task != null) {
      data['task'] = this.task!.toJson();
    }
    return data;
  }
}

class Task {
  int? id;
  String? title;
  String? details;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Task(
      {this.id,
      this.title,
      this.details,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['details'] = this.details;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

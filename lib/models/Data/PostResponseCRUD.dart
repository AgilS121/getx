class PostResponseCRUD {
  bool? status;
  Task? task;

  PostResponseCRUD({this.status, this.task});

  PostResponseCRUD.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? details;
  int? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;

  Task(
      {this.title,
      this.details,
      this.createdBy,
      this.updatedAt,
      this.createdAt,
      this.id});

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    details = json['details'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['details'] = this.details;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

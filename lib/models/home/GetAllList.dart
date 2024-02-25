class GetAllListModel {
  bool? error;
  String? message;
  List<ListStory>? listStory;

  GetAllListModel({this.error, this.message, this.listStory});

  GetAllListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['listStory'] != null) {
      listStory = <ListStory>[];
      json['listStory'].forEach((v) {
        listStory!.add(new ListStory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.listStory != null) {
      data['listStory'] = this.listStory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListStory {
  String? id;
  String? name;
  String? description;
  String? photoUrl;
  String? createdAt;
  double? lat;
  double? lon;

  ListStory(
      {this.id,
      this.name,
      this.description,
      this.photoUrl,
      this.createdAt,
      this.lat,
      this.lon});

  ListStory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photoUrl = json['photoUrl'];
    createdAt = json['createdAt'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['photoUrl'] = this.photoUrl;
    data['createdAt'] = this.createdAt;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
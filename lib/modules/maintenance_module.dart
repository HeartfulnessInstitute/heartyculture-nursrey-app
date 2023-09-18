class MaintenanceModule {
  String? name;
  List<ListData>? listData;

  MaintenanceModule({this.name, this.listData});

  MaintenanceModule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['list_data'] != null) {
      listData = <ListData>[];
      json['list_data'].forEach((v) {
        listData!.add(ListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (listData != null) {
      data['list_data'] = listData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  String? videoUrl;
  String? title;
  String? description;

  ListData({this.videoUrl, this.title, this.description});

  ListData.fromJson(Map<String, dynamic> json) {
    videoUrl = json['video_url'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video_url'] = videoUrl;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
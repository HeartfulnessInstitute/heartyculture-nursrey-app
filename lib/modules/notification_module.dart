class NotificationModule {
  String? plantName;
  String? notificationType;
  String? notificationDescription;
  String? id;

  NotificationModule({
    this.plantName,
    this.notificationType,
    this.notificationDescription,
    this.id,
  });

  NotificationModule.fromJson(Map<String, dynamic> json) {
    plantName = json['plantName'];
    notificationType = json['notificationType'];
    notificationDescription = json['notificationDescription'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plantName'] = plantName;
    data['notificationType'] = notificationType;
    data['notificationDescription'] = notificationDescription;
    data['id'] = id;
    return data;
  }
}

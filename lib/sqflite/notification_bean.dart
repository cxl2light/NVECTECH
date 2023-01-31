class NotificationBean{
  late String deviceName;
  late int distance;
  late int type;
  late String date;
  late String time;
  NotificationBean({required this.deviceName, required this.distance, required this.type, required this.date, required this.time});

  NotificationBean.fromJson(Map<String, dynamic> json) {
    deviceName = json['deviceName'];
    distance = json['distance'];
    type = json['type'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceName'] = deviceName;
    data['distance'] = distance;
    data['type'] = type;
    data['date'] = date;
    data['time'] = time;
    return data;
  }

}
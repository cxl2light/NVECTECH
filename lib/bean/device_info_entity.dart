import 'package:nvectech/generated/json/base/json_field.dart';
import 'package:nvectech/generated/json/device_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class DeviceInfoEntity {

	late String softVer;
	late String hardware;
	late String devName;
  
  DeviceInfoEntity();

  factory DeviceInfoEntity.fromJson(Map<String, dynamic> json) => $DeviceInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $DeviceInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
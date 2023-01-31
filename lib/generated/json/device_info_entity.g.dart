import 'package:nvectech/generated/json/base/json_convert_content.dart';
import 'package:nvectech/bean/device_info_entity.dart';

DeviceInfoEntity $DeviceInfoEntityFromJson(Map<String, dynamic> json) {
	final DeviceInfoEntity deviceInfoEntity = DeviceInfoEntity();
	final String? softVer = jsonConvert.convert<String>(json['softVer']);
	if (softVer != null) {
		deviceInfoEntity.softVer = softVer;
	}
	final String? hardware = jsonConvert.convert<String>(json['hardware']);
	if (hardware != null) {
		deviceInfoEntity.hardware = hardware;
	}
	final String? devName = jsonConvert.convert<String>(json['devName']);
	if (devName != null) {
		deviceInfoEntity.devName = devName;
	}
	return deviceInfoEntity;
}

Map<String, dynamic> $DeviceInfoEntityToJson(DeviceInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['softVer'] = entity.softVer;
	data['hardware'] = entity.hardware;
	data['devName'] = entity.devName;
	return data;
}
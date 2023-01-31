import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nvectech/pages/pop_list_view.dart';
import 'package:nvectech/sqflite/sqf_lite_queue_data.dart';
import 'package:nvectech/utils/screen_utils.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/record_list_item.dart';
import 'package:nvectech/widgets/tab_record.dart';

import '../constant/color_constant.dart';
import '../constant/constant.dart';
import '../generated/l10n.dart';
import '../widgets/back_and_menu.dart';
import '../widgets/img_button.dart';
import '../widgets/pop_record_list.dart';

List<Map<String, dynamic>> recordList = [];
Map<String, dynamic>? map = SPUtil().getJson(SPUtil.deviceInfo);
String currentDevice = 'Cyclops315';

/// 通知记录
class NotificationRecord extends StatefulWidget{

  NotificationRecord({Key? key});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<NotificationRecord> {
  var defaultColor = ColorConstant.itemBg;
  var pressedColor = ColorConstant.itemBgSelected;

  var device = map!['hardware'];
  var searchType = SPUtil().get(SPUtil.notiRecordType) ??  S.current.detection_alarm_all;
  var dateTime = SPUtil().get(SPUtil.notiRecordDate) ??  DateFormat('yyyy.MM.dd').format(DateTime.now());
  var delete = S.current.detection_alarm_delete_record;

  List<String> typeList = [S.current.detection_alarm_all, S.current.detection_alarm_animal, S.current.detection_alarm_person];
  List<String> deleteList = [S.current.detection_alarm_delete_record, S.current.detection_alarm_delete_all];

  @override
  void initState() {
    super.initState();
    currentDevice = map!['hardware'];
    loadRecordListData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: Constant.mainBgOpacity,
            image: AssetImage(Constant.backgroundImg),
          )
      ),

      child: Stack(
        children: [

          Row(
            children: [
              BackAndMenu(),
              const Spacer(),
            ],
          ),

          Column(
            children: [

              const SizedBox(
                height: 70,
              ),

              SizedBox(
                height: 35,
                child: Row(
                  children: [

                    const SizedBox(
                      width: 30,
                    ),

                    TabRecord(
                      buttonText: device,
                      index: 0,
                      onPressed: (index){
                        SqfLiteQueueData.searchDeviceNameList().then((value) {
                          List<String> deviceList = [];
                          for(int i = 0; i < value.length; i++){
                            deviceList.add(value[i]['device_name']);
                          }
                          if(deviceList.isNotEmpty){
                            SPUtil().setStringList(SPUtil.tempListData, deviceList);
                            Navigator.push(
                                context,
                                PopRecordListRoute(child: PopRecordList(
                                  top: 70,
                                  left: 30,
                                  onPressed: (i){
                                    setState(() {
                                      currentDevice = deviceList[i];
                                      device = currentDevice;
                                      loadRecordListData();
                                    });
                                  },
                                ))
                            );
                          }

                        });

                      },
                    ),

                    const SizedBox(
                      width: 30,
                    ),

                    TabRecord(
                      buttonText: searchType,
                      index: 0,
                      onPressed: (index){
                        SPUtil().setStringList(SPUtil.tempListData, typeList);
                        Navigator.push(
                            context,
                            PopRecordListRoute(child: PopRecordList(
                              top: 70,
                              left: 190,
                              onPressed: (i){
                                setState(() {
                                  SPUtil().setString(SPUtil.notiRecordType, typeList[i]);
                                  searchType = typeList[i];
                                  loadRecordListData();
                                });
                              },
                            ))
                        );
                      },
                    ),

                    const SizedBox(
                      width: 30,
                    ),

                    TabRecord(
                      buttonText: dateTime,
                      index: 0,
                      onPressed: (index){
                        SqfLiteQueueData.searchNotificationDateList().then((value) {
                          List<String> dateTimeList = [];
                          for(int i = 0; i < value.length; i++){
                            dateTimeList.add(value[i]['notification_date']);
                          }
                          if( dateTimeList.isNotEmpty){
                            SPUtil().setStringList(SPUtil.tempListData, dateTimeList);
                            Navigator.push(
                                context,
                                PopRecordListRoute(child: PopRecordList(
                                  top: 70,
                                  left: 350,
                                  onPressed: (i){
                                    setState(() {
                                      SPUtil().setString(SPUtil.notiRecordDate, dateTimeList[i]);
                                      dateTime = dateTimeList[i];
                                      loadRecordListData();
                                    });
                                  },
                                ))
                            );
                          }
                        });

                      },
                    ),

                    const SizedBox(
                      width: 30,
                    ),

                    TabRecord(
                      buttonText: delete,
                      index: 0,
                      onPressed: (index){
                        SPUtil().setStringList(SPUtil.tempListData, deleteList);
                        Navigator.push(
                            context,
                            PopRecordListRoute(child: PopRecordList(
                              top: 70,
                              left: 510,
                              onPressed: (i){
                                setState(() {
                                  delete = deleteList[i];
                                  deleteRecord(i);
                                });
                              },
                            ))
                        );
                      },
                    ),

                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ListView.builder(
                  shrinkWrap: true,
                  itemCount: recordList.length,
                  itemBuilder: (context, i){
                    return RecordListItem(
                        distance: '${recordList[i]['target_distance']}M',
                        // typeUrl: recordList[i]['target_type'] == Constant.typePerson ? '${Constant.assetsImg}ic_alarm_person.png' : '${Constant.assetsImg}animal2.png',
                        typeUrl: recordList[i]['target_type'] == Constant.typePerson ? S.current.detection_alarm_person : S.current.detection_alarm_animal,
                        time: recordList[i]['notification_time']);
                  }),

            ],
          ),

        ],
      ),

    );
  }

  static int getSearchType(param) {
    if(param != null){
      if(param == S.current.detection_alarm_animal){
        return 1;
      } else if (param == S.current.detection_alarm_person){
        return 2;
      } else {
        return 0;
      }
    }
    else{
      return 0;
    }
  }

  void loadRecordListData() {
    SqfLiteQueueData.searchData(
        currentDevice,
        getSearchType(SPUtil().get(SPUtil.notiRecordType)),
        SPUtil().get(SPUtil.notiRecordDate) ??  DateFormat('yyyy.MM.dd').format(DateTime.now())).then((value) {
      recordList.clear();
      for(int i = 0; i < value.length; i++){
        recordList.add(value[i]);
      }
      if(recordList.isNotEmpty){
        setState(() {
        });
      }
    });
  }

  void deleteRecord(i) {
    if (i == 0){
      SqfLiteQueueData.deleteOneDay(SPUtil().get(SPUtil.notiRecordDate)).then((value) {
        setState(() {
          SPUtil().setString(SPUtil.notiRecordDate, DateFormat('yyyy.MM.dd').format(DateTime.now()));
          recordList.clear();
        });
      });
    }
    else if (i == 1){
      SqfLiteQueueData.deleteAll().then((value) {
        setState(() {
          SPUtil().setString(SPUtil.notiRecordDate, DateFormat('yyyy.MM.dd').format(DateTime.now()));
          recordList.clear();
        });
      });
    }
  }
}
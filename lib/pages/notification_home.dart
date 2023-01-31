import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/pages/pop_list_view.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/sqflite/notification_bean.dart';
import 'package:nvectech/sqflite/sqf_lite_queue_data.dart';
import 'package:nvectech/utils/sp_util.dart';

import '../constant/constant.dart';
import '../generated/l10n.dart';
import '../widgets/back_and_menu.dart';
import '../widgets/img_button.dart';
import '../widgets/noti_item_selector.dart';

/// 侦测通知主页
class NotificationHome extends StatefulWidget{

  NotificationHome({Key? key}):super(key:key);

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<NotificationHome> {

  var setBg = ColorConstant.itemBg;
  var recordBg = ColorConstant.itemBg;
  var openBg = ColorConstant.itemBg;
  var defaultColor = ColorConstant.itemBg;
  var pressedColor = ColorConstant.itemBgSelected;

  var textDefault = ColorConstant.theme;
  var textSet = ColorConstant.theme;
  var textRecord = ColorConstant.theme;
  var textOpen = ColorConstant.theme;

  var openNotification = SPUtil().getBool(SPUtil.notificationIsOpen) ? S.current.detection_alarm_close : S.current.detection_alarm_open;

  @override
  void initState() {
    super.initState();
    setNotificationData();
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


          Container(
            margin: const EdgeInsets.only(left: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Spacer(),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      textSet = ColorConstant.themeDark;
                      textRecord = textDefault;
                      textOpen = textDefault;
                      MyRouter.pushNoParams(context, MyRouter.notificationSet);
                    });
                  },
                  child: NotiItemSelector(
                    text: S.of(context).detection_alarm_set,
                    textColor: textSet,
                  ),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      textSet = textDefault;
                      textRecord = ColorConstant.themeDark;
                      textOpen = textDefault;
                      MyRouter.pushNoParams(context, MyRouter.notificationRecord);
                    });

                  },
                  child: NotiItemSelector(
                    text: S.of(context).detection_alarm_record,
                    textColor: textRecord,
                  ),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      textSet = textDefault;
                      textRecord = textDefault;
                      textOpen = ColorConstant.themeDark;
                      if(SPUtil().getBool(SPUtil.notificationIsOpen)){
                        print("close");
                        SPUtil().setBool(SPUtil.notificationIsOpen, false);
                        openNotification = S.of(context).detection_alarm_open;
                      } else {
                        print("open");
                        SPUtil().setBool(SPUtil.notificationIsOpen, true);
                        openNotification = S.of(context).detection_alarm_close;
                      }
                    });

                  },
                  child: NotiItemSelector(
                    text: openNotification,
                    textColor: textOpen,
                  ),
                ),

                const Spacer(),

              ],
            ),
          ),

        ],
      ),

    );
  }

  void setNotificationData() {
    String date1 = DateFormat('yyyy.MM.dd').format(DateTime.now());
    String date2 = DateFormat('yyyy.MM.dd').format(DateTime.now().subtract(const Duration(days: 1)));
    String time = DateFormat('HH:mm').format(DateTime.now());
    NotificationBean notificationBean = NotificationBean(deviceName: 'cyclops325', distance: 88, type: 15, date: date1, time: time);
    SqfLiteQueueData.insertData(notificationBean);

  }
}
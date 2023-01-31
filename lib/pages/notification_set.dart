import 'package:flutter/cupertino.dart';
import 'package:nvectech/pages/pop_list_view.dart';
import 'package:nvectech/utils/sp_util.dart';

import '../constant/color_constant.dart';
import '../constant/constant.dart';
import '../generated/l10n.dart';
import '../widgets/back_and_menu.dart';
import '../widgets/img_button.dart';
import '../widgets/noti_item_selector.dart';
import '../widgets/noti_item_set_selector.dart';
import '../widgets/pop_list.dart';


/// 通知设置
class NotificationSet extends StatefulWidget{

  NotificationSet({Key? key});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<NotificationSet> {
  List<String> modeList = [S.current.detection_alarm_mode_mute, S.current.detection_alarm_mode_vibrate, S.current.detection_alarm_mode_sound];
  List<String> durationList = [S.current.detection_alarm_save_one_day, S.current.detection_alarm_save_a_week, S.current.detection_alarm_save_one_month];
  List<String> intervalList = [S.current.detection_alarm_interval_5_seconds, S.current.detection_alarm_interval_1_minute,
    S.current.detection_alarm_interval_10_minutes];
  var modeBg = ColorConstant.itemBg;
  var saveDurationBg = ColorConstant.itemBg;
  var intervalBg = ColorConstant.itemBg;
  var defaultColor = ColorConstant.itemBg;
  var pressedColor = ColorConstant.itemBgSelected;

  var textMode = SPUtil().get(SPUtil.notiSetMode) ?? S.current.detection_alarm_mode_mute;
  var textSaveDuration = SPUtil().get(SPUtil.notiSetDuration) ??  S.current.detection_alarm_save_one_day;
  var textInterval = SPUtil().get(SPUtil.notiSetInterval) ??  S.current.detection_alarm_interval_5_seconds;

  GlobalKey fromSetMode = GlobalKey();
  GlobalKey fromSaveDuration = GlobalKey();
  GlobalKey fromSetInterval = GlobalKey();
  dynamic modeVisibility = true;
  dynamic saveDurationVisibility = true;
  dynamic intervalVisibility = true;

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

                const Spacer(flex: 3,),

                NotiItemSelector(
                  text: S.of(context).detection_alarm_mode,
                  textColor: ColorConstant.theme,
                ),

                const Spacer(flex: 3,),

                NotiItemSelector(
                  text: S.of(context).detection_alarm_save_time,
                  textColor: ColorConstant.theme,
                ),

                const Spacer(flex: 3,),

                NotiItemSelector(
                  text: S.of(context).detection_alarm_interval,
                  textColor: ColorConstant.theme,
                ),

                const Spacer(flex: 3,),

              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 400.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Spacer(flex: 3,),

                Visibility(
                    visible: modeVisibility,
                    child: GestureDetector(
                      onTap: (){
                        // RenderBox renderBox = fromSetMode.currentContext?.findRenderObject() as RenderBox;
                        // var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
                        // print('fromSetMode dx=${offset.dx} dy=${offset.dy}');
                        setState(() {
                          modeVisibility = false;
                          SPUtil().setStringList(SPUtil.tempListData, modeList);
                          Navigator.push(
                              context,
                              PopListRoute(
                                  child: PopList(onPressed: (dynamic index) {
                                    setState(() {
                                      modeVisibility = true;
                                      textMode = modeList[index];
                                    });
                                    SPUtil().setString(SPUtil.notiSetMode, modeList[index]);
                                  }, top: 3,)
                              )
                          );
                        });

                      },
                      child: NotiItemSetSelector(
                        key: fromSetMode,
                        text: textMode,
                      ),
                    ),
                ),

                Visibility(
                    visible: !modeVisibility,
                    child: const SizedBox(
                      height: 35,
                    )
                ),


                const Spacer(flex: 3,),

                Visibility(
                  visible: saveDurationVisibility,
                    child: GestureDetector(
                      onTap: (){
                        saveDurationVisibility = false;
                        setState(() {
                          SPUtil().setStringList(SPUtil.tempListData, durationList);
                          Navigator.push(
                              context,
                              PopListRoute(
                                  child: PopList(onPressed: (dynamic index) {
                                    setState(() {
                                      saveDurationVisibility = true;
                                      textSaveDuration = durationList[index];
                                    });
                                    SPUtil().setString(SPUtil.notiSetDuration, durationList[index]);
                                  }, top: 7,)
                              )
                          );
                        });

                      },
                      child: NotiItemSetSelector(
                        key: fromSaveDuration,
                        text: textSaveDuration,
                      ),
                    ),
                ),

                Visibility(
                    visible: !saveDurationVisibility,
                    child: const SizedBox(
                      height: 35,
                    )
                ),

                const Spacer(flex: 3,),

                Visibility(
                  visible: intervalVisibility,
                    child: GestureDetector(
                      onTap: (){
                        intervalVisibility = false;
                        setState(() {
                          SPUtil().setStringList(SPUtil.tempListData, intervalList);
                          Navigator.push(
                              context,
                              PopListRoute(
                                  child: PopList(onPressed: (dynamic index) {
                                    setState(() {
                                      intervalVisibility = true;
                                      textInterval = intervalList[index];
                                    });
                                    SPUtil().setString(SPUtil.notiSetInterval, intervalList[index]);
                                  }, top: 11,)
                              )
                          );
                        });
                      },
                      child: NotiItemSetSelector(
                        key: fromSetInterval,
                        text: textInterval,
                      ),
                    ),
                ),

                Visibility(
                    visible: !intervalVisibility,
                    child: const SizedBox(
                      height: 35,
                    )
                ),

                const Spacer(flex: 3,),

              ],
            ),
          ),


        ],
      ),


    );
  }
}
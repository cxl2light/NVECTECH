import 'package:flutter/cupertino.dart';
import 'package:nvectech/constant/color_constant.dart';

class LoadingWidget {
  static Widget getLoading({required Color backgroundColor, required Color loadingBgColor}){
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: loadingBgColor, borderRadius: BorderRadius.circular(10.0)),
        width: 70.0,
        height: 70.0,
        alignment: AlignmentDirectional.center,
        child: const SizedBox(
          height: 25.0,
          width: 25.0,
          child: CupertinoActivityIndicator(
            radius: 20.0,
            color: ColorConstant.colorWhite,
          ),
        ),
      ),
    );
  }

  static Widget containerLoadingBody(Widget body,
  {bool loading = true, required Color backgroundColor, required Color loadingBgColor}){
    return Stack(
      children: [
        body,
        Offstage(
          offstage: !loading,
          child: getLoading(
            backgroundColor: backgroundColor, loadingBgColor: loadingBgColor
          ),
        )
      ],
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/widgets/text_style_14.dart';
import 'package:nvectech/widgets/text_style_16.dart';

class RecordListItem extends StatefulWidget{
  final String distance;
  final String typeUrl;
  final String time;
  RecordListItem({Key? key, required this.distance, required this.typeUrl, required this.time});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<RecordListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstant.colorTransparent
      ),
      height: 35,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextStyle16(
                      content: widget.distance,
                    ),
                  )
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextStyle16(
                      content: widget.typeUrl,
                    ),
                  )
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextStyle16(
                      content: widget.time,
                    ),
                  )
              ),
              const Expanded(
                  child: Align()
              ),
            ],
          ),

        ],
      ),
    );
  }
}
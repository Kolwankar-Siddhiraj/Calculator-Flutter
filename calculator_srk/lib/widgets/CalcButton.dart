import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;
  final Widget extraWidget;
  const CalcButton({
    Key key,
    this.text,
    this.fillColor,
    this.textColor = 0xFFFFFFFF,
    this.textSize,
    this.callback,
    this.extraWidget,
  }) : super(key: key);

  double get_font_size(String _key_text) {
    if (text == '(-)') {
      return 20.0;
    } else {
      return 25.0;
    }
  }

  Widget checkWidget() {
    if (text == "*") {
      return extraWidget;
    } else {
      return Text(
        text,
        style: TextStyle(
          fontSize: get_font_size(text),
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          margin: EdgeInsets.all(10),
          child: SizedBox(
            width: 90,
            height: 90,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () {
                callback(text);
              },

              child: checkWidget(),

              // child: Text(
              //   text,
              //   style: TextStyle(
              //     fontSize: 25.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              color: fillColor != null ? Color(fillColor) : null,
              textColor: Color(textColor),
            ),
          ),
        ),
      ),
    );
  }
}

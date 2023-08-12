import 'package:flutter/material.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

class CustomTextFieldTask extends StatelessWidget {
  CustomTextFieldTask(
      {super.key,
      required this.screenSize,
      required this.hintText,
      this.persen = 0.8,
      this.widget,
      this.textController});

  final Size screenSize;
  final String hintText;
  final double persen;
  final Widget? widget;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.08,
      width: screenSize.width * persen,
      padding: const EdgeInsets.only(left: 25, top: 7),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: const Color.fromRGBO(25, 171, 176, 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              autofocus: false,
              cursorColor: Colors.white,
              style: whiteTextStyle.copyWith(fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          widget == null
              ? Container()
              : Container(
                  child: widget,
                )
        ],
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldRecept extends StatefulWidget {
  const TextFieldRecept({super.key,
    required this.hintText,
    required this.controller,
  required this.hintcolor});
  final String hintText;
  final TextEditingController controller;
  final Color hintcolor;

  @override
  State<TextFieldRecept> createState() => _TextFieldReceptState();
}

class _TextFieldReceptState extends State<TextFieldRecept> {
  final FocusNode _onFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onFocus.addListener(textFieldOnFocus);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onFocus.removeListener(textFieldOnFocus);
    _onFocus.dispose();
  }

  void textFieldOnFocus(){
    setState(() {

    });
  }

  Color ifTextFieldOnFocus(){
    return _onFocus.hasFocus || widget.controller.text.isNotEmpty ? Colors.white : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintcolor),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
            borderSide: BorderSide(width:2, color: Color(0xff730909))),
      ),
      controller: widget.controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 10,
      focusNode: _onFocus,
    );
  }
}



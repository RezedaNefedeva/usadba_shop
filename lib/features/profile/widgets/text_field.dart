
import 'package:flutter/material.dart';

class TextFieldProfile extends StatefulWidget {
  const TextFieldProfile({super.key,
  required this.hintText,
  required this.textInputType,
  required this.controller,
  required this.hintcolor,
  required this.helperText,});
  final TextInputType textInputType;
  final String hintText;
  final TextEditingController controller;
  final Color hintcolor;
  final String helperText;

  @override
  State<TextFieldProfile> createState() => _TextFieldProfileState();
}

class _TextFieldProfileState extends State<TextFieldProfile> {
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
        helperText: widget.helperText,
        helperStyle: TextStyle(color: ifTextFieldOnFocus(), fontSize: 10),
        hintStyle: TextStyle(color: widget.hintcolor),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topLeft: Radius.circular(30)),
            borderSide: BorderSide(width:2, color: Color(0xff730909))),
      ),
      controller: widget.controller,
      keyboardType: widget.textInputType,
      focusNode: _onFocus,
    );
  }
}

class TextFieldMultiline extends StatefulWidget {
  const TextFieldMultiline({super.key,
    required this.hintText,
    required this.controller,});
  final String hintText;
  final TextEditingController controller;

  @override
  State<TextFieldMultiline> createState() => _TextFieldMultilineState();
}

class _TextFieldMultilineState extends State<TextFieldMultiline> {
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
        hintStyle: const TextStyle(color: Colors.black26),
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
      maxLines: 5,
      focusNode: _onFocus,
    );
  }
}



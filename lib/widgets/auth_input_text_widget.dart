import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthInputText extends StatefulWidget {
  final inputController;
  final String hintText;
  final IconData icon;
  final bool isPassWord;
  final TextInputType keyType;
  final radius;

  AuthInputText(
      {Key key,
      this.inputController,
      this.hintText,
      this.icon,
      this.isPassWord,
      this.keyType,
      this.radius})
      : super(key: key);

  @override
  _AuthInputTextState createState() => _AuthInputTextState();
}

class _AuthInputTextState extends State<AuthInputText> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white54,
      ),
      child: widget.isPassWord == false
          ? TextField(
              controller: widget.inputController,
              style: TextStyle(fontSize: 14.0),
              keyboardType:
                  widget.keyType == null ? TextInputType.text : widget.keyType,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.black54),
                icon: Icon(
                  widget.icon,
                  color: Colors.black45,
                  size: 15.0,
                ),
                border: InputBorder.none,
                counterText: '',
              ),
            )
          : TextField(
              controller: widget.inputController,
              keyboardType:
                  widget.keyType == null ? TextInputType.text : widget.keyType,
              obscureText: _isObscure,
              style: TextStyle(fontSize: 14.0),
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                  hintStyle: TextStyle(color: Colors.black54),
                  icon:
                      Icon(Icons.lock_open, size: 15.0, color: Colors.black45),
                  border: InputBorder.none,
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 15,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
            ),
    );
  }
}

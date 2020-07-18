import 'package:flutter/material.dart';
import 'package:baredex/ui/shared/shared.dart';

class ConfirmPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String passwordValue;

  const ConfirmPasswordFormField(
      {Key key,
      @required this.controller,
      @required this.hintText,
      @required this.passwordValue})
      : assert(controller != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmPasswordFormFieldState();
}

class _ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
        print("First text field: $text");
      },
      controller: widget.controller,
      decoration: InputDecoration(
        helperText: widget.hintText,
        enabledBorder: UIHelper.enabledBorder,
        focusedBorder: UIHelper.focusedBorder,
        errorBorder: UIHelper.errorBorder,
        focusedErrorBorder: UIHelper.errorBorder,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
      obscureText: !_showPassword,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter ${widget.hintText}';
        }
        if (value.length < 4) {
          return "Enter atleast 4 characters";
        }
        if (value.toString() != widget.passwordValue) {
          return 'Confirm Password not match';
        }
        return null;
      },
    );
  }
}

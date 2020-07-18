import 'package:flutter/material.dart';
import 'package:baredex/ui/shared/shared.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordFormField(
      {Key key, @required this.controller, @required this.hintText})
      : assert(controller != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        return null;
      },
    );
  }
}

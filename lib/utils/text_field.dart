import 'package:flutter/material.dart';
import 'package:meditap/utils/colors.dart';

class Textfield extends StatefulWidget {
  const Textfield({
    super.key,
    required this.label,
    required this.type,
    required this.controller,
    required this.formKey,
    this.isPassword = false,
  });

  final String label;
  final TextInputType type;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final bool isPassword;

  @override
  _TextfieldState createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  late FocusNode focusNode;
  bool isFocused = false;
  bool obscureText = true; 

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      controller: widget.controller,
      focusNode: focusNode,
      obscureText: widget.isPassword && obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        labelText: isFocused ? '' : widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(color: neutral800),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        } else if (widget.isPassword && value != 'Starlight') {
          return 'Please enter a valid password';
        }
        return null;
      },
    );
  }
}

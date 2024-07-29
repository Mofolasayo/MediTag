import 'package:flutter/material.dart';
import 'package:meditap/utils/colors.dart';

class Textfield extends StatefulWidget {
  const Textfield({
    super.key,
    required this.label,
    required this.type,
    required this.controller,
    required this.formKey,
  });

  final String label;
  final TextInputType type;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  _TextfieldState createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        labelText: _isFocused ? '' : widget.label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(color: neutral800)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value';
        } else if (value != 'Starlight') {
          return 'Please enter a valid password';
        }
        return null;
      },
    );
  }
}

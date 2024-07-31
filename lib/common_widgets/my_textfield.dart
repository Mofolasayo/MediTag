import 'package:flutter/material.dart';
import 'package:meditap/common_widgets/regular_dropdown.dart';
import 'package:meditap/common_widgets/schedule_selector.dart';
import 'package:meditap/utils/text_style.dart';

class MyTextfield extends StatefulWidget {
  final String label;
  final String hint;
  final int? maxLines;
  final bool hasDropdown;
  final List<String>? options;
  final bool isMultipleSelection;
  final String title;
  final String? initialValue;
  final TextInputType? keyType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<List<String>>? onChangedMultiple;
  final TextEditingController? controller;

  const MyTextfield({
    Key? key,
    this.controller,
    required this.label,
    required this.hint,
    this.keyType,
    this.maxLines,
    this.hasDropdown = false,
    this.options,
    this.isMultipleSelection = false,
    this.title = "",
    this.initialValue,
    this.onChanged,
    this.onChangedMultiple,
  }) : super(key: key);

  @override
  _MyTextfieldState createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  late TextEditingController _controller;
  List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    if (widget.initialValue != null && widget.isMultipleSelection) {
      selectedOptions = widget.initialValue!.split(', ');
    }
    _controller.addListener(() {
      if (widget.isMultipleSelection) {
        if (widget.onChangedMultiple != null) {
          widget.onChangedMultiple!(selectedOptions);
        }
      } else {
        if (widget.onChanged != null) {
          widget.onChanged!(_controller.text);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: f12_w600_n800),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (widget.hasDropdown &&
                  widget.isMultipleSelection &&
                  widget.title == 'Choose Available times') {
                _showScheduleDialog(context, widget.options, widget.title);
              } else if (widget.hasDropdown) {
                _showRegularDropdownDialog(
                    context, widget.options, widget.title);
              }
            },
            child: widget.hasDropdown
                ? AbsorbPointer(
                    child: _buildTextFormField(),
                  )
                : _buildTextFormField(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      controller: _controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (widget.label.toLowerCase() == 'email address') {
          // Email validation regex
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        } else if (widget.label.toLowerCase() == 'phone number') {
          // Phone validation regex 
          final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
          if (!phoneRegex.hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
        }
        return null;
      },
      maxLines: widget.maxLines,
      keyboardType: widget.keyType,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: f14_w400_n500,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon:
            widget.hasDropdown ? const Icon(Icons.arrow_drop_down) : null,
      ),
    );
  }

  void _showScheduleDialog(
      BuildContext context, List<String>? options, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: ScheduleDialog(
            title: title,
            options: options ?? [],
            initialSelectedOptions: selectedOptions,
            onSelectedOptionsChanged: (List<String> selected) {
              setState(() {
                selectedOptions = selected;
                _controller.text = selected.join(', ');
                if (widget.onChangedMultiple != null) {
                  widget.onChangedMultiple!(selectedOptions);
                }
              });
            },
          ),
        );
      },
    );
  }

  void _showRegularDropdownDialog(
      BuildContext context, List<String>? options, String title) {
    showRegularDropdownDialog(
      context,
      title: title,
      options: options ?? [],
      isMultipleSelection: widget.isMultipleSelection,
      selectedOptions: selectedOptions,
      onSelectionChanged: (selected) {
        setState(() {
          selectedOptions = selected;
          _controller.text = selected.join(', ');
          if (widget.onChangedMultiple != null) {
            widget.onChangedMultiple!(selectedOptions);
          }
        });
      },
    );
  }
}

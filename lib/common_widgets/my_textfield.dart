import 'package:flutter/material.dart';
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
  final String? Function(String?)? validator;
  final TextInputType? keyType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<List<String>>? onChangedMultiple;

  const MyTextfield({
    super.key,
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
    this.validator,
  });

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
            onTap: widget.hasDropdown
                ? () =>
                    _showModalBottomSheet(context, widget.options, widget.title)
                : null,
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
      validator: widget.validator,
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

  void _showModalBottomSheet(
      BuildContext context, List<String>? options, String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return options != null
            ? StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(title),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: options.map((option) {
                          bool isSelected = selectedOptions.contains(option);
                          return ListTile(
                            title: Text(option),
                            leading: widget.isMultipleSelection
                                ? Checkbox(
                                    value: isSelected,
                                    onChanged: (bool? value) {
                                      setModalState(() {
                                        if (value == true) {
                                          selectedOptions.add(option);
                                        } else {
                                          selectedOptions.remove(option);
                                        }
                                      });
                                    },
                                  )
                                : null,
                            onTap: () {
                              if (widget.isMultipleSelection) {
                                setModalState(() {
                                  if (isSelected) {
                                    selectedOptions.remove(option);
                                  } else {
                                    selectedOptions.add(option);
                                  }
                                });
                              } else {
                                setState(() {
                                  _controller.text = option;
                                  Navigator.pop(context);
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              )
            : Container();
      },
    ).whenComplete(() {
      if (widget.isMultipleSelection) {
        setState(() {
          _controller.text = selectedOptions.join(', ');
          if (widget.onChangedMultiple != null) {
            widget.onChangedMultiple!(selectedOptions);
          }
        });
      }
    });
  }
}

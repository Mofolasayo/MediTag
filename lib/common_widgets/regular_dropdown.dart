import 'package:flutter/material.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/text_style.dart';

class RegularDropdownDialog extends StatelessWidget {
  final String title;
  final List<String> options;
  final bool isMultipleSelection;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onSelectionChanged;

  const RegularDropdownDialog({
    Key? key,
    required this.title,
    required this.options,
    required this.selectedOptions,
    required this.isMultipleSelection,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: options.isNotEmpty
              ? StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: f18_w400_n800.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close,
                                    color: neutral800, size: 24),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: options.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return index != options.length - 1
                                ? const Divider(
                                    height: 0.05,
                                    thickness: 0.5,
                                    color: neutral300)
                                : const SizedBox.shrink();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            String option = options[index];
                            bool isSelected = selectedOptions.contains(option);
                            return ListTile(
                              title: Text(
                                option,
                                style: f14_w400_n500.copyWith(
                                  color: neutral800,
                                ),
                              ),
                              leading: isMultipleSelection
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
                                if (isMultipleSelection) {
                                  setModalState(() {
                                    if (isSelected) {
                                      selectedOptions.remove(option);
                                    } else {
                                      selectedOptions.add(option);
                                    }
                                  });
                                } else {
                                  Navigator.pop(context, [option]);
                                }
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                )
              : Container(),
        ),
      ),
    );
  }
}

void showRegularDropdownDialog(
  BuildContext context, {
  required String title,
  required List<String> options,
  required bool isMultipleSelection,
  required List<String> selectedOptions,
  required ValueChanged<List<String>> onSelectionChanged,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RegularDropdownDialog(
        title: title,
        options: options,
        isMultipleSelection: isMultipleSelection,
        selectedOptions: List.from(selectedOptions),
        onSelectionChanged: onSelectionChanged,
      );
    },
  ).then((selected) {
    if (selected != null) {
      onSelectionChanged(List<String>.from(selected));
    }
  });
}

import 'package:flutter/material.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/text_style.dart';

class ScheduleDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> initialSelectedOptions;
  final ValueChanged<List<String>> onSelectedOptionsChanged;

  const ScheduleDialog({
    Key? key,
    required this.title,
    required this.options,
    required this.initialSelectedOptions,
    required this.onSelectedOptionsChanged,
  }) : super(key: key);

  @override
  _ScheduleDialogState createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  late List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = List.from(widget.initialSelectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (BuildContext context, int index) {
                String option = widget.options[index];
                bool isSelected = selectedOptions.contains(option);
                return Column(
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedOptions.add(option);
                            } else {
                              selectedOptions.remove(option);
                            }
                          });
                        },
                      ),
                      title: Text(
                        option.split(';')[0],
                        style: f14_w400_n500.copyWith(
                          color: neutral900,
                        ),
                      ), // Only display day
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: isSelected ? primary50 : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          option.split(';')[1],
                          style: f14_w400_n500.copyWith(
                            color: primary700,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                        height: 0.05, thickness: 0.5, color: neutral300),
                    const SizedBox(height: 13.0),
                  ],
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSelectedOptionsChanged(selectedOptions);
                  Navigator.pop(context);
                },
                child: Text(
                  'Done',
                  style: f16_w600_p500.copyWith(
                    color: primary50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

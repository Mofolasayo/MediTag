import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/utils/icons.dart';

class FilterModal extends StatefulWidget {
  final bool sortAscending;
  final bool sortDescending;
  final List<String> selectedSpecialties;

  FilterModal({
    required this.sortAscending,
    required this.sortDescending,
    required this.selectedSpecialties,
  });

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late bool _sortAscending;
  late bool _sortDescending;
  late List<String> _selectedSpecialties;

  final List<String> _specialties = [
    'Cardiologist',
    'Dermatologist',
    'General Practitioner',
    'Geriatrician',
    'Hematologist',
    'Obstetrics & Gynecologist',
    'Ophthalmologist',
    'Pediatrician',
    'Physician',
    'Psychiatrist',
    'Radiologist',
    'Surgeon',
    'Urologist',
  ];

  @override
  void initState() {
    super.initState();
    _sortAscending = widget.sortAscending;
    _sortDescending = widget.sortDescending;
    _selectedSpecialties = List.from(widget.selectedSpecialties);
  }

  Widget _buildCheckbox(String text, bool value, Function(bool?) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: value ? Colors.blue : Colors.grey.shade300),
          color: value ? Colors.blue.shade50 : Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.blue,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String text, bool value, Function(bool?) onChanged,
      String iconSvg, String sortOrder) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(text, style: TextStyle(fontSize: 14)),
        Spacer(),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Row(
            children: [
              Text(
                sortOrder,
                style: TextStyle(
                    color: value ? Colors.blue : Colors.black, fontSize: 14),
              ),
              SvgPicture.string(
                iconSvg,
                color: value ? Colors.blue : Colors.black,
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Filters',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Text(
                        '(${_selectedSpecialties.length} Selected)',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _sortAscending = false;
                        _sortDescending = false;
                        _selectedSpecialties.clear();
                      });
                    },
                    child: Text('Reset',
                        style: TextStyle(color: Colors.blue, fontSize: 14)),
                  ),
                ],
              ),
            ),
            Divider(),
            Text('Sort by',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildSortOption(
              'Alphabetical',
              _sortAscending,
              (bool? value) {
                setState(() {
                  _sortAscending = value!;
                  if (_sortAscending) _sortDescending = false;
                });
              },
              MediTagIcons.whiteBackIcon,
              'Ascending',
            ),
            _buildSortOption(
              'Alphabetical',
              _sortDescending,
              (bool? value) {
                setState(() {
                  _sortDescending = value!;
                  if (_sortDescending) _sortAscending = false;
                });
              },
              MediTagIcons.mediTapPatientAscendFilter,
              'Descending',
            ),
            SizedBox(height: 10),
            Text('Specialty',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _specialties.length,
                itemBuilder: (context, index) {
                  return _buildCheckbox(
                    _specialties[index],
                    _selectedSpecialties.contains(_specialties[index]),
                    (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedSpecialties.add(_specialties[index]);
                        } else {
                          _selectedSpecialties.remove(_specialties[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'sortAscending': _sortAscending,
                  'sortDescending': _sortDescending,
                  'selectedSpecialties': _selectedSpecialties,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text('Save & Apply',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

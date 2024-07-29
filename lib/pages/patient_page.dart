import 'package:flutter/material.dart';
import 'filter_modal_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/utils/icons.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _doctors = [
    {"name": "Ehimaare Ogundokun", "specialty": "Pediatrician"},
    {"name": "Ademola Frank", "specialty": "Dermatologist"},
    {"name": "Fidelis Rhan", "specialty": "Dermatologist"},
  ];

  List<Map<String, String>> _filteredDoctors = [];
  bool _sortAscending = false;
  bool _sortDescending = false;
  List<String> _selectedSpecialties = [];

  @override
  void initState() {
    super.initState();
    _filteredDoctors = _doctors;
  }

  void _filterDoctors() {
    String searchQuery = _searchController.text.toLowerCase();
    List<Map<String, String>> tempDoctors = _doctors.where((doctor) {
      bool matchesSearch =
          doctor['name']!.toLowerCase().contains(searchQuery) ||
              doctor['specialty']!.toLowerCase().contains(searchQuery);
      bool matchesSpecialty = _selectedSpecialties.isEmpty ||
          _selectedSpecialties.contains(doctor['specialty']);
      return matchesSearch && matchesSpecialty;
    }).toList();

    if (_sortAscending) {
      tempDoctors.sort((a, b) => a['name']!.compareTo(b['name']!));
    } else if (_sortDescending) {
      tempDoctors.sort((a, b) => b['name']!.compareTo(a['name']!));
    }

    setState(() {
      _filteredDoctors = tempDoctors;
    });
  }

  void _showFilterModal() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 1.0,
        child: FilterModal(
          sortAscending: _sortAscending,
          sortDescending: _sortDescending,
          selectedSpecialties: _selectedSpecialties,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _sortAscending = result['sortAscending'];
        _sortDescending = result['sortDescending'];
        _selectedSpecialties = result['selectedSpecialties'];
        _filterDoctors();
      });
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search'),
          content: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search by Name or Specialty',
              prefixIcon: SvgPicture.string(MediTagIcons.mediTapPatientSearch),
            ),
            onChanged: (value) => _filterDoctors(),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFD), // Setting background color
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(132.0), // height
        child: AppBar(
          flexibleSpace: Container(
            width: 430,
            padding: EdgeInsets.fromLTRB(20, 73, 20, 11),
            child: Opacity(
              opacity: 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('St Michael Hospital',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.string(
                            MediTagIcons.mediTapPatientSearch,
                            color: Colors.black),
                        onPressed: _showSearchDialog,
                      ),
                      IconButton(
                        icon: SvgPicture.string(
                            MediTagIcons.mediTapPatientAscendFilter,
                            color: Colors.black),
                        onPressed: _showFilterModal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                itemCount: _filteredDoctors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        _filteredDoctors[index]['name']![0],
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor:
                          Color(0xFFE3F2FD), // Light blue background
                    ),
                    title: Text(_filteredDoctors[index]['name']!,
                        style: TextStyle(color: Colors.black)),
                    subtitle: Text(_filteredDoctors[index]['specialty']!,
                        style: TextStyle(color: Colors.grey)),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     // Todo
                      //     builder: (context) => DoctorInfo(
                      //       name: _filteredDoctors[index]['name']!,
                      //       specialty: _filteredDoctors[index]['specialty']!,
                      //     ),
                      //   ),
                      // );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

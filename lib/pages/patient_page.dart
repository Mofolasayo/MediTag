import 'package:flutter/material.dart';
import '../screens/doctor_info.dart';
import 'filter_modal_page.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _doctors = [
    // Example data, can be fetched from a backend or NFC later
    {"name": "Ehimaare Ogundokun", "specialty": "Pediatrician"},
    {"name": "Ademola Frank", "specialty": "Dermatologist"},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('St Michael Hospital'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name or Specialty',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => _filterDoctors(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredDoctors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(_filteredDoctors[index]['name']![0]),
                    ),
                    title: Text(_filteredDoctors[index]['name']!),
                    subtitle: Text(_filteredDoctors[index]['specialty']!),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorInfo(
                            name: _filteredDoctors[index]['name']!,
                            specialty: _filteredDoctors[index]['specialty']!,
                          ),
                        ),
                      );
                    },
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

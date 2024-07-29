import 'package:flutter/material.dart';

class DoctorInfo extends StatelessWidget {
  final String name;
  final String specialty;

  DoctorInfo({required this.name, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Add to contacts action
                        },
                        icon: Icon(Icons.person_add, color: Colors.white),
                        label: Text('Add to contacts',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    specialty,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3)),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.blue),
                    title: Text('0800000000'),
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.blue),
                    title: Text('sampleemail@gmail.com'),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bio',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal)),
                  SizedBox(height: 10),
                  Text(
                    'Dr. $name is a board-certified $specialty with 15 years of experience. '
                    'Specializes in preventative care, infectious diseases, and asthma management, '
                    'dedicated to promoting children\'s health and wellness.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text('Available Times',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal)),
                  SizedBox(height: 10),
                  _buildAvailabilityRow('Monday', '9:00am - 5:00pm'),
                  _buildAvailabilityRow('Tuesday', '9:00am - 5:00pm'),
                  _buildAvailabilityRow('Wednesday', '9:00am - 5:00pm'),
                  _buildAvailabilityRow('Thursday', '9:00am - 5:00pm'),
                  _buildAvailabilityRow('Friday', '9:00am - 5:00pm'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityRow(String day, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: TextStyle(fontSize: 16)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(5),
            ),
            child:
                Text(time, style: TextStyle(fontSize: 16, color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}

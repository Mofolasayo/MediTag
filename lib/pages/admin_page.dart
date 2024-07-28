import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/screens/admin/dashboard.dart';
import 'package:meditap/screens/admin/search.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      const Dashboard(),
      const Search(),
      
    ];
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.string(MediTagIcons.mediTapLogo),
        centerTitle: true,
      ),
      body: items[currentIndex],
      bottomNavigationBar: Padding(
        
        padding:
            const EdgeInsets.only(left: 35.0, right: 35.0, top: 5, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(248, 248, 248, 1),
            border: Border.all(
              color: neutral200,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            
            child: BottomNavigationBar(
              iconSize: 24,

              type: BottomNavigationBarType.fixed,
              
              backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
              elevation: 6,
              // selectedItemColor: primary,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.string(MediTagIcons.homeIcon),
                    label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: SvgPicture.string(MediTagIcons.searchIcon),
                    label: 'Search'),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

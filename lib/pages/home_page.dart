import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/course_model.dart';
import 'package:test_project/pages/courses_page.dart';
import 'package:test_project/pages/dashboard_page.dart';
import 'package:test_project/pages/lessons_page.dart';
import 'package:test_project/pages/login_page.dart';
import 'package:test_project/pages/profile_page.dart';
import 'package:test_project/providers/role_provider.dart';
import 'package:test_project/services/course_service.dart';
import 'package:test_project/utils/course_card.dart';
import 'package:test_project/utils/dialog_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  final _controller = TextEditingController();
  Course? _searchedCourse;
  bool _isSearchDialogVisible = true;

static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    CoursesScreen(),        
    ProfileScreen(),         
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _searchCourseById() async {
    String courseId = _controller.text.trim();
    if (courseId.isNotEmpty) {
      try {
        int id = int.parse(courseId);
        var token = Hive.box('auth').get('token');
        CourseService courseService = CourseService(token);
        Course? course = await courseService.fetchCourseById(id);

       
        setState(() {
          _searchedCourse = course;
          _isSearchDialogVisible = false;
          _controller.clear(); 
        });


      } catch (e) {
       
        print("Error fetching course: $e");
      }
    }
    Navigator.of(context).pop();
  }
  void _showSearchDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSearch: _searchCourseById,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isSearchDialogVisible) {
        _showSearchDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return 

    Scaffold(
      appBar: AppBar(
        title: const Text('Course',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[800],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/courses');
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: _showSearchDialog,
        child: Icon(Icons.search,),
        ),
        body: Center(
        child: _searchedCourse == null
            ? _widgetOptions.elementAt(_selectedIndex)
            : CourseCard(course: _searchedCourse!),
        ),
    );
  }
}
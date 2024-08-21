import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_project/services/auth_service.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? name;
  String? email;
  String? role;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }
  
  Future<void> _loadUserDetails() async {
    final authService = AuthService();
    await Hive.openBox('auth');
    
    setState(() {
      name = authService.getName();
      email = authService.getEmail();
      role = authService.getRole();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/60111.jpg'),
                radius: 50.0,
              ),
            ),
            Divider(height: 60.0, color: Colors.grey[400],),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              name ?? 'Loading...',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 30.0,),
            Text(
              'ROLE',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              role ?? 'Loading...',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 30.0,),
            Text(
              'EMAIL',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0
              ),
            ),
            Text(
              email ?? 'Loading...',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 30.0,),
            IconButton(
                  onPressed: (){
                    final authService = AuthService();
                    authService.logout();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: Icon(Icons.logout),
                color: Colors.black,
                ),
          ],
        ),
        ),


    );
  }
}
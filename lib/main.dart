import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_project/pages/courses_page.dart';
import 'package:test_project/pages/home_page.dart';
import 'package:test_project/pages/lessons_page.dart';
import 'package:test_project/pages/login_page.dart';
import 'package:test_project/pages/profile_page.dart';
import 'package:test_project/pages/registration_page.dart';
import 'package:test_project/providers/course_provider.dart';
import 'package:test_project/providers/role_provider.dart';
import 'package:test_project/services/auth_service.dart';
import 'package:test_project/services/course_service.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('auth');

  runApp(MultiProvider(
    providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<RoleProvider>(create: (_) => RoleProvider()),
        ChangeNotifierProvider(create: (context) => CourseProvider(CourseService(context.read<AuthProvider>().token))),
      ],
    child: const MyApp(
      
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/registration':(context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
        '/courses': (context) => const CoursesScreen(),
        '/profile':(context) => const ProfileScreen(),
        '/lessons': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return LessonsScreen(courseId: args);
        }
      },
      
    );
  }
}

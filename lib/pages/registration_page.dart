import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  Future<void> _register(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool success = await authProvider.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _roleController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      
      Navigator.popAndPushNamed(context, '/login');
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Please check your credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Registration"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Name"
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
            ),
            TextField(
              controller: _roleController,
              decoration: InputDecoration(
                hintText: "Role"
              ),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Password"
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () =>_register(context), 
              child: Text("Register")
              ),
        
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text("Already have an account? Login")
                )
          ],
        ),
      ),
    );
  }
}
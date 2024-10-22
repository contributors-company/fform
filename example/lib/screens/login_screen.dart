import 'package:example/forms/forms.dart';
import 'package:example/widgets/drawer.dart';
import 'package:fform/fform.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final LoginForm _form = LoginForm.zero();

  Future<bool> _checkForm() async {
    _form.change(
      email: _emailController.value.text,
      password: _passwordController.value.text,
    );
    return await _form.checkAsync();
  }

  Future<void> _login() async {
    _checkForm().then((value) {
      if (value) {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Row(
              children: [
                Icon(
                  Icons.lock_open,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text('Welcome', style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerApp(),
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: FFormBuilder(
            form: _form,
            builder: (context, form) {
              return Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _form.email.exception.toString(),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _form.password.exception.toString(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                  Text(_form.isValid.toString())
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

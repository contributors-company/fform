import 'package:example_fform/forms/forms.dart';
import 'package:example_fform/widgets/drawer.dart';
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

  _checkForm() {
    _form.change(
        email: _emailController.value.text,
        password: _passwordController.value.text);
    return _form.isValid;
  }

  _login() {
    if (_checkForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
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
    } else {
      for (var element in _form.allExceptions) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(element.toString(),
                    style: const TextStyle(color: Colors.white))
              ],
            ),
          ),
        );
      }
    }
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
                      errorText: form.email.exception.toString(),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: form.password.exception.toString(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

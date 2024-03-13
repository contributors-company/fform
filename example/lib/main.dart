import 'package:example_fform/fields/name_field.dart';
import 'package:example_fform/fields/password_confirm_field.dart';
import 'package:example_fform/fields/password_field.dart';
import 'package:example_fform/login_form.dart';
import 'package:fform/fform.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FForm Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LoginForm form = LoginForm();
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;

  _checkForm() {
    if (form.isValid) {
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
      for (var element in form.exceptions) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  element.toString(),
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
      }
    }
  }

  _nameListener() {
    form.changeFields(name: _nameController.value.text);
  }

  _passwordListener() {
    form.changeFields(
      password: _passwordController.value.text,
      passwordConfirm: _passwordConfirmController.value.text,
    );
  }

  _passwordConfirmListener() {
    form.changeFields(
      password: _passwordController.value.text,
      passwordConfirm: _passwordConfirmController.value.text,
    );
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();

    _nameController.addListener(_nameListener);
    _passwordController.addListener(_passwordListener);
    _passwordConfirmController.addListener(_passwordConfirmListener);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.removeListener(_nameListener);
    _passwordController.removeListener(_passwordListener);
    _passwordConfirmController.removeListener(_passwordConfirmListener);
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FForm'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FFormBuilder<LoginForm>(
          form: form,
          builder: (BuildContext context, LoginForm form) {
            return Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    errorText: form.hasCheck
                        ? form.get<NameField>().exception.toString()
                        : null,
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    errorText: form.hasCheck
                        ? form.get<NameField>().exception.toString()
                        : null,
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    errorText: form.hasCheck
                        ? form.get<PasswordField>().exception.toString()
                        : null,
                  ),
                ),
                TextField(
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(
                    errorText: form.hasCheck
                        ? form.get<PasswordConfirmField>().exception.toString()
                        : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: _checkForm,
                  child: const Text('Check Form'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

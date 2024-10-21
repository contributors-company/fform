import 'package:fform/fform.dart';
import 'package:flutter/material.dart';

import '../forms/exception_multi.dart';

class ExceptionMultiScreen extends StatefulWidget {
  const ExceptionMultiScreen({super.key});

  @override
  State<ExceptionMultiScreen> createState() => _ExceptionMultiScreenState();
}

class _ExceptionMultiScreenState extends State<ExceptionMultiScreen> {
  late TextEditingController _passwordController;
  late ExceptionMultiForm _form;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController()..addListener(_change);
    _form = ExceptionMultiForm();
  }

  void _change() => _form.password.value = _passwordController.text;

  @override
  void dispose() {
    super.dispose();
    _passwordController
      ..removeListener(_change)
      ..dispose();
  }

  void _submit() {
    if (_form.isValid) {
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
      for (var element in _form.exceptions) {
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

  bool _showException(bool? isHaveException) {
    if (isHaveException == null) return false;
    return !isHaveException;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exception Multi Validation'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: FFormBuilder(
            form: _form,
            builder: (context, form) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  Visibility(
                    visible: form.password.exception != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        if (_showException(
                            form.password.exception?.isMinLengthValid))
                          const Text('Password must be at least 8 characters'),
                        const SizedBox(height: 5),
                        if (_showException(
                            form.password.exception?.isSpecialCharValid))
                          const Text('Password must have special character'),
                        const SizedBox(height: 5),
                        if (_showException(
                            form.password.exception?.isNumberValid))
                          const Text('Password must have number'),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

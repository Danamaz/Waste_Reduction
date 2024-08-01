import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_management/pages/homepage.dart';
import 'package:waste_management/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/services/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuthService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 70, left: 15, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 50),
                name(),
                const SizedBox(height: 25),
                emailField(),
                const SizedBox(height: 25),
                phone(),
                const SizedBox(height: 25),
                password(),
                const SizedBox(height: 25),
                confirmPassword(),
                const SizedBox(height: 30),
                signUpButton(),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget name() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        hintText: 'Enter your name',
        prefixIcon: Icon(Icons.person_outline),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget phone() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        hintText: 'Enter your phone number',
        prefixIcon: Icon(Icons.phone),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (value.length < 10) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email_outlined),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.zero),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        } else if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget password() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        focusedBorder:
            const OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder:
            const OutlineInputBorder(borderRadius: BorderRadius.zero),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  Widget confirmPassword() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureText2,
      decoration: InputDecoration(
        hintText: 'Confirm your password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText2
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye,
          ),
          onPressed: () {
            setState(() {
              _obscureText2 = !_obscureText2;
            });
          },
        ),
        focusedBorder:
            const OutlineInputBorder(borderRadius: BorderRadius.zero),
        enabledBorder:
            const OutlineInputBorder(borderRadius: BorderRadius.zero),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        } else if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget signUpButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _signUp();
        }
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  void _signUp() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signing Up...')),
    );

    try {
      User? user = await _auth.signUpEmailPassword(
        phone: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
      );

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error signing up. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}

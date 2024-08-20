import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/services/database.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late final DatabaseService _databaseService =
      DatabaseService(uid: currentUser!.uid);
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            margin: const EdgeInsets.only(top: 70, left: 15, right: 15),
            child: Column(
              children: <Widget>[
                const Text("Add recipient's details",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                const SizedBox(height: 50),
                name(),
                const SizedBox(height: 25),
                emailfield(),
                const SizedBox(height: 25),
                phonenumber(),
                const SizedBox(height: 25),
                address(),
                const SizedBox(height: 50),
                button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget name() {
    return TextFormField(
      controller: _name,
      decoration: const InputDecoration(
        labelText: 'Name',
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget emailfield() {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'email address',
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(),
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

  Widget phonenumber() {
    return TextFormField(
      controller: _phone,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'phone number',
        prefixIcon: Icon(Icons.phone_outlined),
        border: OutlineInputBorder(),
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

  Widget address() {
    return TextFormField(
      controller: _address,
      decoration: const InputDecoration(
        labelText: 'Enter location or address',
        prefixIcon: Icon(Icons.location_city_outlined),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter location or address';
        }
        return null;
      },
    );
  }

  Widget button() {
    return ElevatedButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _addRecipient();
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 25),
        ));
  }

  void _addRecipient() async {
    try {
      await _databaseService.storeRecipients(
        name: _name.text,
        phone: _phone.text,
        address: _address.text,
        email: _email.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipient added successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }
}

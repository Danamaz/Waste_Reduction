import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_management/services/database.dart';

class Additem extends StatefulWidget {
  const Additem({super.key});

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  DateTime? _selectedDate;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late final DatabaseService _databaseService =
      DatabaseService(uid: currentUser!.uid);

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAdditem(context);
      },
      tooltip: 'Add Item',
      child: const Icon(Icons.add),
    );
  }

//Add Item Dialog
  void _showAdditem(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Item'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      itemNameField(),
                      const SizedBox(height: 10),
                      itemField(),
                      const SizedBox(height: 10),
                      expiryDateField(context),
                      const SizedBox(height: 20),
                      _imageFile != null
                          ? Image.file(_imageFile!, height: 100)
                          : const Text('No image selected'),
                      ElevatedButton(
                        onPressed: () {
                          _showImageSourceSelection(setState);
                        },
                        child: const Text('Add Image'),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _nameController.clear();
                    _descriptionController.clear();
                    _expiryDateController.clear();
                    setState(() {
                      _imageFile = null;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _addItem();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

//Item Name FormField
  Widget itemNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: 'Item Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an Item Name';
        }
        return null;
      },
    );
  }

//Expiry Date FormField
  Widget expiryDateField(BuildContext context) {
    return TextFormField(
      controller: _expiryDateController,
      decoration: const InputDecoration(labelText: 'Expiry Date'),
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Select an Expiry Date';
        }
        return null;
      },
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
            _expiryDateController.text = pickedDate.toString().split(' ')[0];
          });
        }
      },
    );
  }

//Item Description FormField
  Widget itemField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(labelText: 'Item Description'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an Item Description';
        }
        return null;
      },
    );
  }

  //Image Picker
  Future<void> _pickImage(ImageSource source, StateSetter setState) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

//Image source Selection
  void _showImageSourceSelection(StateSetter setState) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.gallery, setState);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.camera, setState);
            },
          ),
        ],
      ),
    );
  }

//Adding Item to Firestore
  void _addItem() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Adding Item to Store')));
    try {
      if (_imageFile != null) {
        final imageUrl = await _databaseService.uploadImage(_imageFile!);

        if (imageUrl != null) {
          await _databaseService.storeItemData(
            _nameController.text,
            _descriptionController.text,
            _selectedDate!.toString(),
            imageUrl,
          );

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item added successfully')));
          Navigator.of(context).pop();
          _nameController.clear();
          _descriptionController.clear();
          _expiryDateController.clear();
          setState(() {
            _imageFile = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to upload image')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select an image')));
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error ${e.toString}')));
    }
  }
}

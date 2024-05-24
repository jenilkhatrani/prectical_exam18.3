import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'ContactListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(),
    );
  }
}
class CreateContactScreen extends StatefulWidget {
  @override
  _CreateContactScreenState createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  int _id = 1; // This should be dynamically set based on existing contacts

  @override
  void initState() {
    super.initState();
    _initializeId();
  }

  Future<void> _initializeId() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync().where((item) => item.path.endsWith(".txt")).toList();
    if (files.isNotEmpty) {
      _id = files.length + 1;
    }
  }

  Future<void> _saveContact() async {
    if (_nameController.text.isEmpty || _mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields.')));
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${_id}_${_nameController.text}_${_mobileController.text}.txt';
    final file = File(path);
    await file.writeAsString('Name: ${_nameController.text}\nMobile: ${_mobileController.text}');
    setState(() {
      _id++;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Contact saved successfully.')));
    Navigator.pop(context); // Go back to the contact list screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}

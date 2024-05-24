import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practical_exam/ContactDetailScreen.dart';
import 'package:practical_exam/main.dart';
import 'dart:io';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<File> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync().where((item) => item.path.endsWith(".txt")).toList();
      setState(() {
        _contacts = files.cast<File>();
      });
    } catch (e) {
      print('Error loading contacts: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: _contacts.isEmpty
          ? Center(child: Text('No contact found'))
          : ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contactFile = _contacts[index];
          final fileName = contactFile.path.split('/').last;
          final parts = fileName.split('_');
          final id = parts[0];
          final name = parts[1];
          final mobile = parts[2].split('.').first;
          return ListTile(
            title: Text(name),
            subtitle: Text(mobile),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetailScreen(id: id, name: name, mobile: mobile)));
              // Navigate to Contact Detail Screen
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>CreateContactScreen()));
          // Navigate to Create Contact Screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

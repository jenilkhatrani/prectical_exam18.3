import 'package:flutter/material.dart';

class ContactDetailScreen extends StatelessWidget {
  final String id;
  final String name;
  final String mobile;

  ContactDetailScreen({required this.id, required this.name, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: $id', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Mobile: $mobile', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to update contact
              },
              child: Text('Update Contact'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to delete contact
              },
              child: Text('Delete Contact'),
            ),
          ],
        ),
      ),
    );
  }
}

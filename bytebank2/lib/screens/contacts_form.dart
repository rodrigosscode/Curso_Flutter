import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:flutter/material.dart';

class ContactsForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ContactsFormState();
  }
}

class ContactsFormState extends State<ContactsForm> {

  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final ContactDAO _dao = ContactDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full name",
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: "Account number",
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    final String name = _nameController.text;
                    final int account = int.tryParse(_accountNumberController.text);
                    final Contact newContact = Contact(0, name, account);
                    _dao.save(newContact).then((id) => Navigator.pop(context));
                  },
                  child: Text("Create"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

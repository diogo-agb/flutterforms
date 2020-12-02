import 'package:flutter/material.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextFormField(
                      'First name',
                      (value) =>
                          value.isEmpty ? 'Please enter your first name' : null,
                      (value) {
                    setState(() {
                      _user.firstName = value;
                    });
                  }),
                  _buildTextFormField(
                      'Last name',
                      (value) =>
                          value.isEmpty ? 'Please enter your last name' : null,
                      (value) {
                    setState(() {
                      _user.lastName = value;
                    });
                  }),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                    child: Text('Subscribe'),
                  ),
                  SwitchListTile(
                    title: Text('Monthly Newsletter'),
                    value: _user.newsletter,
                    onChanged: (bool val) {
                      setState(() {
                        _user.newsletter = !_user.newsletter;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        _user.save();
                        _showDialog(context);
                        print(_user.firstName);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(labeltext, validator, onsave) {
    return TextFormField(
      style: TextStyle(
        //Cor do texto no input
        color: Colors.red,
      ),
      decoration: InputDecoration(
        focusedErrorBorder:
            //Cor da borda com erro e com foco
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        errorStyle: TextStyle(
          //Cor do texto com erro e com foco
          color: Colors.purple,
        ),
        errorBorder:
            //Cor do erro
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        focusedBorder:
            //Cor do foco
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
        enabledBorder: UnderlineInputBorder(
            //Cor da borda
            borderSide: BorderSide(color: Colors.green)),
        labelText: labeltext,
      ),
      validator: validator,
      onSaved: onsave,
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Submitting form'),
      ),
    );
  }
}

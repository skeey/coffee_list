import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Update your brew settings.', style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Name',
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown[400], width: 2.0)
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0)
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0)
              )
            ),
            // textInputAction: TextInputAction.next,
            // focusNode: _emailFocus,
            // onFieldSubmitted: (term) {
            //   _emailFocus.unfocus();
            //   FocusScope.of(context).requestFocus(_passwordFocus);
            // },
            validator: (val) {
              if (val.isEmpty) {
                return 'The name can not be empty';
              }
              return null;
            },
            onChanged: (val) {
              setState(() => _currentName = val);
            },
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
              hintText: 'Name',
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown[400], width: 2.0)
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0)
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0)
              )
            ),
            value: _currentSugars ?? '0',
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugar${sugar != '0' && sugar != '1' ? 's' : ''}')
              );
            }).toList(),
            onChanged: (val) {
              setState(() => _currentSugars = val);
            },
          ),
          SizedBox(height: 20.0),
          Slider(
            value: (_currentStrength ?? 100).toDouble(),
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            min: 100,
            max: 900,
            divisions: 8,
            onChanged: (val) {
              setState(() => _currentStrength = val.round());
            },
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.brown[400],
            child: Text('Update', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
          )
        ]
      ),
    );
  }
}
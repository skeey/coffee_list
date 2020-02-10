import 'package:coffee_list/services/database.dart';
import 'package:flutter/material.dart';
import 'package:coffee_list/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your brew settings.', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
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
                  value: _currentSugars ?? userData.sugars,
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
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
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
                  child: loading ? Container(
                    width: 15.0,
                    height: 15.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.brown[100]),
                      strokeWidth: 2,
                    ),
                  ) : Text(
                    'Update',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength
                      );
                      setState(() => loading = false);

                      Navigator.pop(context);
                    }
                  },
                )
              ]
            ),
          );
        } else {
          return Container(
            child: Center(
              child: SpinKitDoubleBounce(
                color: Colors.brown,
                size: 35.0,
              )
            ),
          );
        }
      }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:todo/services/authservice.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.toggleSignIn,super.key});
  
  final void Function() toggleSignIn;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String _loginEmail = '';
  String _loginPassword = '';
  String _error = '';

  void authenticateLogIn () async{ 
    if(_loginKey.currentState!.validate()){
      _loginKey.currentState!.save();

    dynamic result = await _auth.logIn(_loginEmail, _loginPassword);
    if (result == null){
      setState(() {
        _error = "Incorrect E-mail or password";
      });
    }
    }  // other logic for storing etc...
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
        actions: [
          TextButton(
            onPressed: widget.toggleSignIn,
            child: Text(
              "Sign up",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: 
          Form(
            key: _loginKey,
            child: Center(
                child: SingleChildScrollView(
                  child: Column(
                     children: [
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35 ),
                       child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 241, 239, 239),
                          labelText: "E-mail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black)
                            )
                          ),
                              
                        validator: (value) {
                          if(value == null || value.isEmpty || !value.contains("@")){
                            return "Empty or invalid E-mail";
                          }
                          return null;               
                        },     
                        onSaved: (email) {
                          _loginEmail = email!; 
                        },        
                      ),
                     ),
                              
                    Padding(
                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35 ),
                       child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 241, 239, 239),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black)
                            )
                          ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Empty password";
                          }
                          return null;               
                        },             
                        onSaved: (password){
                          _loginPassword = password!;
                        },
                      ),
                     ),
                     ElevatedButton(onPressed: authenticateLogIn, child: Text("Log in")),
                     const SizedBox(height: 15,),
                     Text(_error, style: TextStyle(color: Colors.red),)
                     ],
                     
                  ),
                ),
              ),
                     
      )
    );
  }
}
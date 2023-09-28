import 'package:flutter/material.dart';
import 'package:todo/services/authservice.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({required this.toggleSignIn,super.key});
  final void Function() toggleSignIn;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String _error = '';
  String _signUpPassword = '';
  String _signUpEmail = '';

  void authenticate () async{ 
    if(_signUpKey.currentState!.validate()){
      _signUpKey.currentState!.save();

    dynamic result = await _auth.signUp(_signUpEmail, _signUpPassword);
    if (result == null){
      setState(() {
        _error = "E-mail invalid or already exists.";
      });
    }
    }  // other logic for storing etc...
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        actions: [
          TextButton(
            onPressed: widget.toggleSignIn,
            child: const Text(
              "Log in",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),

      body: 
          Form(
            key: _signUpKey,
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
                          if(value == null ||value.isEmpty || !value.contains("@")){
                            return "Empty or invalid E-mail";
                          }
                          return null;               
                        },     
                        onSaved: (email) {
                          _signUpEmail = email!; 
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
                          if(value == null || value.isEmpty || value.length < 6){
                            return "Empty or invalid password, password must be at least 6 characters";
                          }
                          return null;               
                        },             
                        onChanged: (password){
                          _signUpPassword = password;
                        },
                         onSaved: (password){
                          _signUpPassword = password!;
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
                          labelText: "Confirm password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black)
                            )
                          ),
                        validator: (value) {
                          if(value != _signUpPassword ){
                            _signUpPassword = '';
                            return "Password does not match";
                          }
                          return null;               
                        },             
                       
                      ),
                     ),
                     ElevatedButton(onPressed: authenticate, child: Text("Sign up")),

                     const SizedBox(height: 15,),

                     Text(_error, style: TextStyle(color: Colors.red),)
                     ]
                  ),
                ),
              ),
                     
      ),
    );
  }
}

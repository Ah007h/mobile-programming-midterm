import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya/models/user.dart';
import 'package:homestay_raya/views/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../serverconfig.dart';
import 'Registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool remember = false;

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 240,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90)),
                        color: Color.fromARGB(255, 26, 96, 194),
                        gradient: LinearGradient(
                            colors: [
                              (Color.fromARGB(255, 59, 119, 203)),
                              (Color.fromARGB(255, 19, 93, 197))
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 70),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 125,
                          width: 125,
                          child: Image.asset('assets/images/booking.png'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20, top: 20),
                          alignment: Alignment.bottomRight,
                          child: const Text(
                            "Login",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white70),
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200]),
                    alignment: Alignment.center,
                    child: TextFormField(
                        controller: _emailEditingController,
                        cursorColor: const Color.fromARGB(255, 59, 119, 203),
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 59, 119, 203),
                            ),
                            hintText: "Enter Email",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid email!';
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return 'Please enter valid email';
                          }
                          return null;
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200]),
                    alignment: Alignment.center,
                    child: TextFormField(
                        controller: _passEditingController,
                        obscureText: true,
                        cursorColor: const Color.fromARGB(255, 59, 119, 203),
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Color.fromARGB(255, 59, 119, 203),
                            ),
                            hintText: "Password",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter correct password!';
                          }
                          if (value.length < 10) {
                            return 'Password must be at least 10 characters';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Checkbox(value: remember, onChanged: _onRememberMe),
                      const Text("Remember Me"),
                    ],
                  ),
                  Container(
                      width: 250,
                      height: 40,
                      color: Colors.blue,
                      child: SizedBox(
                          child: ElevatedButton(
                        onPressed: _login,
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an accounr? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (Content) =>
                                        const RegistrationScreen()));
                          },
                          child: const Text("Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.amber)),
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Open as "),
                        GestureDetector(
                          onTap: () {
                            _logoutDialog();
                          },
                          child: const Text("Guest",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.amber)),
                        )
                      ]),
                  const SizedBox(
                    height: 18,
                  )
                ],
              ))),
    );
  }

  void _onRememberMe(bool? value) {
    remember = value!;
    setState(() {
      if (value) {
        _saveRemovePref(true);
      } else {
        _saveRemovePref(false);
      }
    });
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    remember = (prefs.getBool('remember')) ?? false;
    if (email.isNotEmpty) {
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
        remember = true;
      });
    }
  }

  void _saveRemovePref(bool value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String email = _emailEditingController.text;
      String password = _passEditingController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value) {
        await prefs.setString('email', email);
        await prefs.setString('pass', password);
        await prefs.setBool('rememebr', true);
        Fluttertoast.showToast(
            msg: "Preference Stored",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      } else {
        await prefs.setString('email', '');
        await prefs.setString('pass', '');
        await prefs.setBool('rememebr', false);
        _emailEditingController.text = "";
        _passEditingController.text = "";
        Fluttertoast.showToast(
            msg: "Preference Removed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Preference Faild",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      remember = false;
    }
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    String _email = _emailEditingController.text;
    String _pass = _passEditingController.text;
    http.post(Uri.parse("${ServerConfig.SERVER}php/login_user.php"),
        body: {"email": _email, "password": _pass}).then((response) {
      print(response.body);
      var jsonResponse = json.decode(response.body);
      print(response.statusCode);
      User user = User.fromJson(jsonResponse['data']);
      try {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && jsonResponse['status'] == "success") {
          print(jsonResponse);
          User user = User.fromJson(data['data']);

          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => MainScreen(user: user)));
        } else {
          Fluttertoast.showToast(
              msg: "Login Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
        }
      } catch (ex) {
        print("error happened");
      }
    });
  }

  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Guest?",
            style: TextStyle(),
          ),
          content: const Text("You can't use all app features..."),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Back",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Okay",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('email', '');
                await prefs.setString('pass', '');
                await prefs.setBool('remember', false);
                User user = User(
                  id: "0",
                  email: "unregistered@email.com",
                  name: "unregistered",
                  phone: "0123456789",
                );
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(user: user)));
              },
            ),
          ],
        );
      },
    );
  }
}

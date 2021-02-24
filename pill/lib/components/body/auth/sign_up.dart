// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//   SharedPreferences sharedPreferences;
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : ListView(
//                 children: <Widget>[
//                   headerSection(),
//                   textSection(),
//                   buttonSection(),
//                 ],
//               ),
//       ),
//     );
//   }

//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();
//   Container buttonSection() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 40.0,
//       padding: EdgeInsets.symmetric(horizontal: 15.0),
//       margin: EdgeInsets.only(top: 15.0),
//       child: RaisedButton(
//         onPressed: emailController.text == "" || passwordController.text == ""
//             ? null
//             : () {
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 // signIn(emailController.text, passwordController.text);
//               },
//         elevation: 0.0,
//         color: Colors.purple,
//         child: Text("Sign In", style: TextStyle(color: Colors.white70)),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//       ),
//     );
//   }

//   Container textSection() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             controller: emailController,
//             cursorColor: Colors.white,
//             style: TextStyle(color: Colors.white70),
//             decoration: InputDecoration(
//               icon: Icon(Icons.email, color: Colors.white70),
//               hintText: "Email",
//               border: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white70)),
//               hintStyle: TextStyle(color: Colors.white70),
//             ),
//           ),
//           SizedBox(height: 30.0),
//           TextFormField(
//             controller: passwordController,
//             cursorColor: Colors.white,
//             obscureText: true,
//             style: TextStyle(color: Colors.white70),
//             decoration: InputDecoration(
//               icon: Icon(Icons.lock, color: Colors.white70),
//               hintText: "Password",
//               border: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white70)),
//               hintStyle: TextStyle(color: Colors.white70),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container headerSection() {
//     return Container(
//       margin: EdgeInsets.only(top: 50.0),
//       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
//       child: Text("App NodeJs Mongodb Login",
//           style: TextStyle(
//               color: Colors.white70,
//               fontSize: 40.0,
//               fontWeight: FontWeight.bold)),
//     );
//   }
// }

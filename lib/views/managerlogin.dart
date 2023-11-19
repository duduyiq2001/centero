import "package:flutter/material.dart";
import "package:centero/views/managerhome.dart";
import "package:centero/controllers/managerauthentication.dart";
import 'package:centero/models/loginresponse.dart';

class ManagerLogin extends StatefulWidget {
  const ManagerLogin({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ManagerLogin> {
  final TextEditingController emailct = TextEditingController();
  final TextEditingController passwordct = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Manager login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailct,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Manager email",
                    hintText: "Enter valid Manageremail"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordct,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter Password"),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                "Forgot Password",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  LoginResponse response =
                      await managerlogin(emailct.text, passwordct.text);
                  if (response == LoginResponse.success) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ManagerHome()));
                  } else {
                    if (response == LoginResponse.devicetokenfailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("failed to fetch token!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    if (response == LoginResponse.sigininfailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("invalid credential!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            const Text("New User? Create Account")
          ],
        ),
      ),
    );
  }
}
import "package:flutter/material.dart";
import "package:centero/views/clienthome.dart";
import "package:centero/controllers/residentauthentication.dart";
import 'package:centero/models/loginresponse.dart';

class ResidentLogin extends StatefulWidget {
  const ResidentLogin({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ResidentLogin> {
  final TextEditingController propertyct = TextEditingController();
  final TextEditingController unitct = TextEditingController();
  final TextEditingController socialct = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Centero Login Page"),
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
                controller: propertyct,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Property name",
                    hintText: "Enter valid centero property name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: unitct,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Unit number",
                    hintText: "Enter Unit number"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: socialct,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "social security number",
                    hintText: "Enter social security number"),
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
                  int unit_number = -1;
                  try {
                    unit_number = int.parse(unitct.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Unit Number is a number"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  LoginResponse response = await residentlogin(
                      propertyct.text, unit_number, socialct.text);
                  if (response == LoginResponse.success) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ClientHome()));
                  } else {
                    if (response == LoginResponse.devicetokenfailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("failed to fetch token!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    if (response == LoginResponse.customtokenfailedtogenerate) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("invalid credential!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    if (response == LoginResponse.sigininfailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Something is wrong, please contact admin!"),
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

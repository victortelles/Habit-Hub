import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_hub/screens/email_login.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              children: [
                  SizedBox(
                    height: 500,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25.0,0,0,0),
                        child: Text(
                          "Es tu momento.",
                          style: GoogleFonts.archivo(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25.8,0,0,0)
                      ),
                      Text(
                        "Encuentra amigos y comparte tus metas con\n ellos",
                        style: GoogleFonts.archivo(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          )
                        )
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,8,20.0,8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EmailLogin())
                                )
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_forward,
                                    color: Colors.black),
                                  ),
                                  Text(
                                    "Continue with E-mail",
                                    style: TextStyle(
                                      color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox( width:110, child:  ElevatedButton(onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text("Aqui se pretende iniciar sesion con Apple ID"),
                            action: SnackBarAction(
                              label: "OK", onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),)
                        );
                      }, child: Text("Apple", style: TextStyle( color: Colors.black),))),
                      SizedBox( width:110, child:  ElevatedButton(onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text("Aqui se pretende iniciar sesion con Google"),
                            action: SnackBarAction(
                              label: "OK", onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),)
                        );
                      }, child: Text("Google", style: TextStyle( color: Colors.black)))),
                      SizedBox( width:110, child:  ElevatedButton(onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text("Aqui se pretende iniciar sesion con Facebook"),
                            action: SnackBarAction(
                              label: "OK", onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),)
                        );
                      }, child: Text("Facebook", style: TextStyle( color: Colors.black))))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "By continuing you agree with our terms of use & privacy\n policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          );
        }
      ),
    );
  }
}
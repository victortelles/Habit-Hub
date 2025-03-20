import 'package:flutter/material.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crea tu cuenta", style: TextStyle( fontWeight: FontWeight.bold),),
      ),
      backgroundColor: const Color.fromARGB(255, 227, 234, 238),
      body:  Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,8,0,5),
                child: Text("Nombre", style: TextStyle( fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,20),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.clear),
                      hintText: "Nombre"
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,8,0,5),
                child: Text("Correo Electrónico", style: TextStyle( fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,20),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.clear),
                      hintText: "E-mail"
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,8,0,5),
                child: Text("Fecha de nacimiento", style: TextStyle( fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,20),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.clear),
                      hintText: "mm/dd/yyyy"
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 410,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent
                        ), 
                        onPressed:(){},
                         child: Text(
                          "Siguiente",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        )
                    )
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  FlutterLogo(size: 76,),
                  SizedBox(height: 16,),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                    ),
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    //Futuro botão da Google
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: Image.asset("imagens/google.png"),
                        ),
                      const SizedBox(width: 20),
                      const Text(
                        "Login com Google",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                       )
                      ],
                    )
                  ),
                  const SizedBox(height: 16),
                  TextButton(onPressed: (){},
                      child: const Text(
                        'Criar uma nova conta',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

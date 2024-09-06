import 'package:flutter/material.dart';
import 'package:time_list/services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _comfirmaSenhaController =
      TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const FlutterLogo(size: 76),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        hintText: 'Nome',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _comfirmaSenhaController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Confirma Senha',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_senhaController.text ==
                            _comfirmaSenhaController.text) {
                          authService.cadastratUsuario(
                              email: _emailController.text,
                              senha: _senhaController.text,
                              nome: _nomeController.text);
                        }
                      },
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

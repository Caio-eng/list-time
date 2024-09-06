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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_senhaController.text ==
                                _comfirmaSenhaController.text) {
                              authService
                                  .cadastratUsuario(
                                      email: _emailController.text,
                                      senha: _senhaController.text,
                                      nome: _nomeController.text)
                                  .then((String? erro) {
                                if (erro != null) {
                                  final snackBar = SnackBar(
                                    content: Text(erro),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            } else {
                              const snackBar = SnackBar(
                                content: Text("As Senhas não correspondem"),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: const Text(
                            "Cadastrar",
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ],
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

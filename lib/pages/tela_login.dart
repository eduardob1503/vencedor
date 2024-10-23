// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../pages/tela_materias.dart';
import '../biometria/biometria_service.dart'; // Pode ser necessário se houver funcionalidade de biometria

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _isBiometricSupported = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    setState(() {
      _isBiometricSupported = canCheckBiometrics;
    });
    if (_isBiometricSupported) {
      _authenticateBiometrics();
    }
  }

  Future<void> _authenticateBiometrics() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Autentique-se para continuar',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (authenticated) {
        // Navegue para a próxima tela após autenticação bem-sucedida
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MateriasScreen()),
        );
      }
    } catch (e) {
      print('Erro na autenticação biométrica: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Adicionar ação aqui, como navegação de retorno
          },
        ),
      ),
      backgroundColor: Color(0xFFF3F3F3), // Fundo cinza claro
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded( // Envolve a parte principal da tela para permitir melhor controle da altura
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 450, // Define uma altura específica para o card
                  width: 350,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      
                      // Adiciona o logo
                      Image.network(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/13/logo-2372752_1280.png',
                        height: 100, // Defina uma altura para manter a consistência
                      ),
                      
                      SizedBox(height: 10),

                      // Campo de texto para o e-mail
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 30),

                      // Campo de texto para a senha
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),

                      // Botão de recuperar senha
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: TextButton(
                            onPressed: () {
                              // Lógica para recuperar senha
                            },
                            child: Text('Recuperar senha'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      // Botão de entrar
                      ElevatedButton(
                        onPressed: () {
                          // Aqui você pode adicionar navegação para a próxima página
                          
                        },
                        child: Text('Entrar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                      ),

                      SizedBox(height: 20),

                      // Botão de autenticação biométrica
                      if (_isBiometricSupported)
                        ElevatedButton.icon(
                          onPressed: _authenticateBiometrics,
                          icon: Icon(Icons.fingerprint),
                          label: Text('Entrar com biometria'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Rodapé com um container fixo
            Container(
              height: 50, // Define a altura do rodapé
              width: double.infinity, // Ocupa toda a largura da tela
              color: Colors.blue, // Cor de fundo do rodapé
            ),
          ],
        ),
      ),
    );
  }
}

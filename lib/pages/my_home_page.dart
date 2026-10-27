import 'package:firebase_otp/data/firebase/auth_service.dart';
import 'package:flutter/material.dart';
import '../config/flavors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AuthService _authService;

  @override
  initState() {
    super.initState();
    _authService = AuthService();
  }

  bool get isAuthenticated => _authService.currentUser != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(F.title)),
      body: Column(
        children: [
          Center(
            child: Text(
              'Bienvenido a la aplicación',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16),
          if (!isAuthenticated) ...[
            ElevatedButton(
              onPressed: () async {
                await _login();
                setState(() {});
              },
              child: const Text('Iniciar sesión'),
            ),
          ] else
            ElevatedButton(
              onPressed: () async {
                await _logout();
                setState(() {});
              },
              child: const Text('Cerrar sesión'),
            ),

          const SizedBox(height: 16),

          Text('Usuario autenticado: ${_authService.currentUser?.email}'),
        ],
      ),
    );
  }

  Future<void> _login() async {
    final email = 'user@example.com';
    final password = 'abc123';

    await _authService
        .signInWithEmailAndPassword(email, password)
        .then((user) {
          print('Usuario autenticado: ${user!.email}');
        })
        .catchError((error) {
          print('Error al autenticar: $error');
        });
  }

  Future<void> _logout() async {
    await _authService.signOut();
    print('Usuario desconectado');
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bienvenido a la aplicación',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class AuthView extends StatelessWidget {
  final AuthService authService;
  AuthView({super.key, required this.authService});

  final _emailController = TextEditingController(text: 'user@example.com');
  final _passwordController = TextEditingController(text: 'abc123');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          controller: _emailController,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: Icon(Icons.lock_outline),
          ),
          controller: _passwordController,
        ),
      ],
    );
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    await authService
        .signInWithEmailAndPassword(email, password)
        .then((user) {
          print('Usuario autenticado: ${user!.email}');
        })
        .catchError((error) {
          print('Error al autenticar: $error');
        });
  }
}

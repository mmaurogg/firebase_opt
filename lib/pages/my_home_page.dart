import 'package:firebase_otp/data/firebase/auth_service.dart';
import 'package:firebase_otp/pages/widgets/product_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(F.title),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.network(
                F.image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        actions: [
          if (_authService.isAuthenticated)
            IconButton(icon: const Icon(Icons.logout), onPressed: _logout)
          else
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              onPressed: _login,
              label: const Text('login'),
            ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Bienvenido a la aplicación',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          const SizedBox(height: 16),

          Text('Usuario autenticado: ${_authService.currentUser?.email}'),

          const SizedBox(height: 16),

          ProductCard(
            imageUrl: 'https://via.placeholder.com/150',
            title: 'Producto 1',
            description: 'Descripción del producto 1',
            price: 19.99,
          ),
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

    setState(() {});
  }

  Future<void> _logout() async {
    await _authService.signOut();
    print('Usuario desconectado');
    setState(() {});
  }
}

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_otp/data/firebase/auth_service.dart';
import 'package:firebase_otp/data/firebase/firestore_service.dart';
import 'package:firebase_otp/data/firebase/real_time_db_service.dart';
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
  late RealTimeDbService _realTimeDbService;
  late FirestoreService _firestore;

  bool isLoading = false;

  @override
  initState() {
    super.initState();
    _authService = AuthService();
    _realTimeDbService = RealTimeDbService();
    _firestore = FirestoreService();
  }

  @override
  Widget build(BuildContext context) {
    final welcomeMessage = _authService.isAuthenticated
        ? 'Bienvenido ${_authService.currentUser?.email}'
        : 'Usuario no autenticado';
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
          if (isLoading)
            CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_authService.isAuthenticated)
            CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
            )
          else
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              onPressed: _login,
              label: const Text('login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(title: Text(welcomeMessage)),
            backgroundColor: F.color.withAlpha(80),
          ),

          StreamBuilder(
            stream: _firestore.getProducts(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (asyncSnapshot.hasError) {
                final error = asyncSnapshot.error;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: Text('Error: $error')),
                  ),
                );
              }

              final products = asyncSnapshot.data ?? [];

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = products[index];

                  return StreamBuilder<int?>(
                    stream: _realTimeDbService.getStock(product.id),
                    builder: (context, asyncSnapshot) {
                      return ProductCard(
                        title: product.name,
                        price: product.price,
                        imageUrl: product.imageUrl,
                        stock: asyncSnapshot.data?.toString(),
                        onTap: () {
                          _firestore.placeOrder(
                            productId: product.id,
                            quantity: 1,
                          );
                        },
                      );
                    },
                  );
                }, childCount: products.length),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    final email = 'user@example.com';
    final password = 'abc123';
    setState(() {
      isLoading = true;
    });

    await _authService
        .signInWithEmailAndPassword(email, password)
        .then((user) async {
          await _setClaim();
          print('Usuario autenticado: ${user!.email}');
        })
        .catchError((error) {
          print('Error al autenticar: $error');
        });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _logout() async {
    await _authService.signOut();
    print('Usuario desconectado');
    setState(() {});
  }

  Future<void> _setClaim() async {
    try {
      final callable = FirebaseFunctions.instance.httpsCallable(
        'setAppIdClaim',
      );
      await callable.call({'appId': F.name});

      final user = _authService.currentUser;
      final userResult = await user!.getIdTokenResult(true);
      print('AppId: ${userResult.claims}');
    } catch (e) {
      print('Error al establecer el appId: $e');
    }
  }
}

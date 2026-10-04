import 'package:flutter/material.dart';
import 'telas/pagina_inicial.dart';

void main() {
  runApp(const MeuAppJogos());
}

class MeuAppJogos extends StatelessWidget {
  const MeuAppJogos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamer Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const PaginaInicial(),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/jogo.dart';

class ListaDeFavoritos extends StatelessWidget {
  final List<Jogo> jogos;

  ListaDeFavoritos(this.jogos);

  @override
  Widget build(BuildContext context) {
    final favoritos = jogos.where((jogo) => jogo.favorito).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Jogos Favoritos',
            style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, index) {
          final jogo = favoritos[index];
          return Card(
            child: ListTile(
              title: Text(jogo.nome),
              subtitle: Text('Gênero: ${jogo.genero} | Plataforma: ${jogo.plataforma} | Percentual: ${jogo.percentualConclusao}%'),
            ),
          );
        },
      ),
    );
  }
}

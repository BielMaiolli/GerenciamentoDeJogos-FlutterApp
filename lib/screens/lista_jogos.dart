import 'package:flutter/material.dart';
import '../models/jogo.dart';
import 'adicionar_jogo.dart';
import 'detalhes_jogo.dart';
import 'lista_favoritos.dart';

class ListaDeJogos extends StatefulWidget {
  @override
  _ListaDeJogosState createState() => _ListaDeJogosState();
}

class _ListaDeJogosState extends State<ListaDeJogos> {
  List<Jogo> jogos = [
    Jogo(
      nome: 'The Witcher 3',
      genero: 'RPG',
      percentualConclusao: 50, // Exemplo de percentual
      plataforma: 'PC',
      favorito: false,
    ),
    Jogo(
      nome: 'FIFA 2024',
      genero: 'Esportes',
      percentualConclusao: 80, // Exemplo de percentual
      plataforma: 'PS5',
      favorito: true,
    ),
  ];

  void marcarComoFavorito(int index) {
    setState(() {
      jogos[index].favorito = !jogos[index].favorito;
    });
  }

  void adicionarNovoJogo(Jogo jogo) {
    setState(() {
      jogos.add(jogo);
    });
  }

  void editarJogo(Jogo jogoEditado) {
    setState(() {
      final index = jogos.indexWhere((jogo) => jogo.nome == jogoEditado.nome);
      if (index != -1) {
        jogos[index] = jogoEditado;
      }
    });
  }

  void excluirJogo(int index) {
    setState(() {
      jogos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Meus Jogos',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaDeFavoritos(jogos)),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: jogos.length,
          itemBuilder: (context, index) {
            final jogo = jogos[index];
            return Card(
              child: ListTile(
                title: Text(jogo.nome),
                subtitle: Text('Gênero: ${jogo.genero} | Plataforma: ${jogo.plataforma} | Percentual: ${jogo.percentualConclusao}%'),
                trailing: IconButton(
                  icon: Icon(
                    jogo.favorito ? Icons.favorite : Icons.favorite_border,
                    color: jogo.favorito ? Colors.red : null,
                  ),
                  onPressed: () => marcarComoFavorito(index),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesDoJogo(
                        jogo: jogo,
                        onEditar: (jogoEditado) => editarJogo(jogoEditado),
                        onExcluir: () => excluirJogo(index),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdicionarJogo(
                onSave: adicionarNovoJogo,
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/jogo.dart';

class AdicionarJogo extends StatefulWidget {
  final Function(Jogo) onSave;

  AdicionarJogo({required this.onSave});

  @override
  _AdicionarJogoState createState() => _AdicionarJogoState();
}

class _AdicionarJogoState extends State<AdicionarJogo> {
  final _nomeController = TextEditingController();
  final _generoController = TextEditingController();
  final _percentualConclusaoController = TextEditingController();
  String? _plataformaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Jogo',
                 style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _generoController,
              decoration: InputDecoration(labelText: 'Gênero'),
            ),
            TextField(
              controller: _percentualConclusaoController,
              decoration: InputDecoration(labelText: 'Percentual de Conclusão'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              hint: Text('Selecione uma plataforma'),
              value: _plataformaSelecionada,
              onChanged: (String? novaPlataforma) {
                setState(() {
                  _plataformaSelecionada = novaPlataforma;
                });
              },
              items: [
                'PC',
                'PS4',
                'PS5',
                'Xbox',
                'Switch',
                'Mobile',
              ].map<DropdownMenuItem<String>>((String plataforma) {
                return DropdownMenuItem<String>(
                  value: plataforma,
                  child: Text(plataforma),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_plataformaSelecionada != null) {
                  final novoJogo = Jogo(
                    nome: _nomeController.text,
                    genero: _generoController.text,
                    percentualConclusao: int.tryParse(_percentualConclusaoController.text) ?? 0,
                    plataforma: _plataformaSelecionada!,
                    favorito: false,
                  );
                  widget.onSave(novoJogo);
                  Navigator.pop(context); // Volta para a lista após adicionar
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

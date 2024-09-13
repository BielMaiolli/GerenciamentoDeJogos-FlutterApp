import 'package:flutter/material.dart';
import '../models/jogo.dart';

class DetalhesDoJogo extends StatefulWidget {
  final Jogo jogo;
  final Function(Jogo) onEditar;
  final VoidCallback onExcluir;

  DetalhesDoJogo({
    required this.jogo,
    required this.onEditar,
    required this.onExcluir,
  });

  @override
  _DetalhesDoJogoState createState() => _DetalhesDoJogoState();
}

class _DetalhesDoJogoState extends State<DetalhesDoJogo> {
  final _nomeController = TextEditingController();
  final _generoController = TextEditingController();
  final _percentualConclusaoController = TextEditingController();
  String? _plataformaSelecionada; // Campo para selecionar plataforma

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.jogo.nome;
    _generoController.text = widget.jogo.genero;
    _percentualConclusaoController.text = widget.jogo.percentualConclusao.toString();
    _plataformaSelecionada = widget.jogo.plataforma; // Inicializar plataforma selecionada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Jogo',
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
                // Adicione outras plataformas conforme necessário
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
                  widget.jogo.nome = _nomeController.text;
                  widget.jogo.genero = _generoController.text;
                  widget.jogo.percentualConclusao = int.tryParse(_percentualConclusaoController.text) ?? 0;
                  widget.jogo.plataforma = _plataformaSelecionada!; // Atualizar plataforma
                  
                  widget.onEditar(widget.jogo);
                  Navigator.pop(context); // Volta para a lista após editar
                }
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onExcluir();
                Navigator.pop(context); // Volta para a lista após excluir
              },
              child: Text('Excluir'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // Atualizar a cor do botão
            ),
          ],
        ),
      ),
    );
  }
}

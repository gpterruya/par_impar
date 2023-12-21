// resultado.dart

import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  final String winner;
  final String loser;

  Resultado({required this.winner, required this.loser});

  @override
  State<Resultado> createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Resultado do Jogo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text('Vencedor: ${widget.winner}'),
          Text('Perdedor: ${widget.loser}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Reset the game by navigating back to the main screen
              Navigator.pop(context);
            },
            child: Text('Jogar Novamente'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:par_impar/aposta.dart';
import 'package:par_impar/lista.dart';
import 'package:par_impar/resultado.dart';
import 'package:par_impar/jogo.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  List<Map<String, dynamic>> itens = [];

  int exibirTela = 1;
  late Aposta aposta;
  late Lista lista;
  late Resultado resultado;
  late Jogo jogo;

  @override
  void initState() {
    lista = Lista(callback: (username) {
      // Switch to the Aposta screen
      setState(() {
        exibirTela = 1;
      });
    });

    aposta = Aposta(callback: (username, valor, numero, parImpar) {
      setState(() {
        jogo = Jogo(
          usernameLocal: username,
          usernameRemoto: '', // Set this when selecting an opponent
          valor: valor,
          parImpar: parImpar,
          numero: numero,
        );
        exibirTela = 2;
      });
    });
    resultado = Resultado(winner: '', loser: '');

    super.initState();
  }

  Widget selecionaTela() {
    if (exibirTela == 1) {
      return aposta;
    } else if (exibirTela == 2) {
      return lista;
    } else {
      return resultado;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Par ou Ímpar')),
      body: selecionaTela(),
      floatingActionButton: exibirTela == 1
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  exibirTela = 2; // Switch to the Lista screen
                });
              },
              child: Icon(Icons.list),
            )
          : null,
    );
  }
}

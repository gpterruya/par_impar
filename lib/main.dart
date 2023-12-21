import 'package:flutter/material.dart';
import 'package:par_impar/tela_principal.dart';

// POST - https://par-impar.glitch.me/novo
// BODY - {"username": "edson"}

// POST - https://par-impar.glitch.me/aposta
// "parimpar": 1 - impar / 2 - par
// BODY - {"username": "edson", "valor": 100, "parimpar": 1, "numero": 3}

// GET - https://par-impar.glitch.me/jogar/edson/joao
// RETORNO - {
//     "vencedor": {
//         "username": "joao",
//         "valor": 100,
//         "parimpar": 2,
//         "numero": 3
//     }
// }

void main() {
  runApp(_Inicio());
}

class _Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Par ou Impar",
        home: Scaffold(
          body: TelaPrincipal(),
        ));
  }
}

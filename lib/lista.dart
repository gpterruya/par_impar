import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Lista extends StatefulWidget {
  Function(String) callback;
  List<String> players = []; // List to store player usernames

  Lista({required this.callback});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  void initState() {
    super.initState();
    // Fetch the list of players when the widget is initialized
    fetchPlayers();
  }

  Future<void> fetchPlayers() async {
    try {
      var response =
          await http.get(Uri.parse('https://par-impar.glitch.me/jogadores'));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('jogadores') &&
            responseBody['jogadores'] is List<dynamic>) {
          List<dynamic> jogadoresList = responseBody['jogadores'];

          // Explicitly cast elements to String
          setState(() {
            widget.players = jogadoresList
                .map((player) => player['username'].toString())
                .toList();
          });
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error fetching players: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching players: $e');
    }
  }

  Future<void> fetchAndDisplayPoints(String username) async {
    try {
      // Check if the widget is still mounted before proceeding
      if (!mounted) {
        return;
      }

      var response = await http
          .get(Uri.parse('https://par-impar.glitch.me/pontos/$username'));

      // Check if the widget is still mounted before updating the UI
      if (!mounted) {
        return;
      }

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('pontos')) {
          // Display the points in some way, e.g., show an alert
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pontos de $username'),
                content: Text('Pontos: ${jsonData['pontos']}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Fechar'),
                  ),
                ],
              );
            },
          );
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error fetching player points: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching player points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Refresh the list when the button is pressed
            fetchPlayers();
          },
          child: const Text('Atualizar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Switch to the Aposta screen
            widget.callback('');
          },
          child: const Text('Ir para Aposta'),
        ),
        ListView.builder(
          itemBuilder: (ctx, idx) {
            return ListTile(
              title: Text(widget.players[idx]),
              onTap: () async {
                // Fetch and display points for the selected player
                await fetchAndDisplayPoints(widget.players[idx]);
              },
            );
          },
          itemCount: widget.players.length,
          shrinkWrap: true,
        ),
      ],
    );
  }
}

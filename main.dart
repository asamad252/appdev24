import 'package:flutter/material.dart';
import 'package:flutter_application_6/colors_type_pokemon.dart';
import 'package:flutter_application_6/detail_screen.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
        centerTitle: true,
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (dataProvider.hasError) {
            return Center(child: Text('Error: ${dataProvider.error}'));
          } else {
            return GridView.builder(
              itemCount: dataProvider.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = dataProvider.pokemons[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(pokemonDetails: pokemon),
                      ),
                    );
                  },
                  child: Card(
                    color: getColorForType(pokemon['type'][0]),
                    child: Column(
                      children: <Widget>[
                        Image.network(pokemon['img']),
                        Text(
                          pokemon['name'],
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: getColorForType(pokemon['type'][0]),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            pokemon['type'][0],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 8.0 / 10.0,
              ),
            );
          }
        },
      ),
    );
  }
}

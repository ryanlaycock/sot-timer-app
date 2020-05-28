import 'package:flutter/material.dart';
import 'package:sottimer/services/Food.dart';

class Home extends StatelessWidget {

  final List<Food> foods = [
    Food(name: 'Fish', cookingTime: 40, iconUrl: 'Fish_Olive_PlentiFin.png'),
    Food(name: 'Trophy Fish', cookingTime: 90, iconUrl: 'Fish_Ruby_SplashTail.png'),
    Food(name: 'Meat', cookingTime: 60, iconUrl: 'Chicken.png'),
    Food(name: 'Kraken', cookingTime: 120, iconUrl: 'Kraken_Meat.png'),
    Food(name: 'Megalodon', cookingTime: 120, iconUrl: 'Meg_Meat.png'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Text("Ahoy! What shall ye be cookin'?"),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/timer', arguments: foods[index]);
                          },
                          title: Text(foods[index].name),
                          trailing: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 64,
                            ),
                            child: Image.asset(
                                'assets/${foods[index].iconUrl}',
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}
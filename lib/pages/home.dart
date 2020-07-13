import 'package:flutter/material.dart';
import 'package:sottimer/services/Food.dart';

class Home extends StatelessWidget {

  final List<Food> foods = [
    Food(name: 'Fish', cookingTime: 5, iconUrl: 'Fish_Olive_PlentiFin.png'),
    Food(name: 'Trophy Fish', cookingTime: 90, iconUrl: 'Fish_Ruby_SplashTail.png'),
    Food(name: 'Meat', cookingTime: 60, iconUrl: 'Chicken.png'),
    Food(name: 'Kraken', cookingTime: 120, iconUrl: 'Kraken_Meat.png'),
    Food(name: 'Megalodon', cookingTime: 120, iconUrl: 'Meg_Meat.png'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Container(
                 margin: const EdgeInsets.only(top: 10),
                 child: Text(
                    "Ahoy! What shall ye be cookin' today?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      letterSpacing: 2,
                      height: 1.2,
                    ),
                   textAlign: TextAlign.center,
                  ),
               ),
              Expanded(
                child: Center(
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: Container(
                          child: Card(
                            color: Color(0xFF031010),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/timer', arguments: foods[index]);
                              },
                              title: Text(
                                foods[index].name,
                                style: TextStyle(color: Colors.white70, fontSize: 25),
                              ),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Game content and materials are trademarks and copyrights of their respective publisher and its licensors. All rights reserved.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
      ),
    );
  }
}
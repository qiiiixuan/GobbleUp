import 'package:GobbleUp/src/data/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SavedRestaurantFuture extends StatelessWidget {
  final Future<Map<String, dynamic>?> future;

  const SavedRestaurantFuture({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No restaurant data available.'));
        } else {
          final restaurant = snapshot.data!;
          return SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
              ),
              clipBehavior: Clip.antiAlias,
              color: Color(0xFFFF8989),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${restaurant['username']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${restaurant['Description']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Row(
                          children: [
                            Icon(Icons.table_restaurant),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                                '${restaurant['Cuisine']}'
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.monetization_on),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                                '${restaurant['PriceRange']}'
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.train),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                                '${restaurant['MRT']}'
                            ),
                          ],
                        ),

                      ],
                    )
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                ],
              ),
            ),
          );
        }
      },
    );
  }
}
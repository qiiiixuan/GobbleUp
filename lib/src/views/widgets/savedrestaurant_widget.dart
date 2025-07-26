import 'package:GobbleUp/src/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedRestaurantFuture extends StatelessWidget {
  final VoidCallback onRefresh;
  final Future<Map<String, dynamic>?> future;
  final User? user;

  const SavedRestaurantFuture({super.key, required this.onRefresh, required this.future, required this.user});

  void deleteSaved() async {
    final Map<String, dynamic>? restaurant = await future;
    await DatabaseService().deleteSavedRestaurant(gobblerUid: user?.uid, gobbledUid: restaurant?['uid']);
    onRefresh();
  }

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
          return Stack(
            children: [
              Card(
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
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white70,
                  ),
                  onPressed: deleteSaved,
                ),
              ),
            ]
          );
        }
      },
    );
  }
}
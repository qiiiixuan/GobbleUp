import 'package:GobbleUp/src/data/constants.dart';
import 'package:GobbleUp/src/services/database_service.dart';
import 'package:GobbleUp/src/views/widgets/savedrestaurant_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';

class GobblerSavedPage extends StatefulWidget {
  const GobblerSavedPage({super.key});

  @override
  State<GobblerSavedPage> createState() => _GobblerHomePageState();
}

class _GobblerHomePageState extends State<GobblerSavedPage> {
  final User? user = AuthService().currentUser;
  List<Future<Map<String, dynamic>>> savedRestaurants = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSavedRestaurants();
  }

  // Load card deck of restaurants
  Future<void> loadSavedRestaurants() async {
    savedRestaurants = await DatabaseService().getSavedRestaurants(
      gobblerUid: user?.uid,
    );
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(
            left: 5.0,
            top: 5.0,
            bottom: 5.0,
          ),
          child: Hero(
            tag: 2,
            child: Image(
              image: AssetImage('assets/images/gobbler.png'),
            ),
          ),
        ),
        title: Text(
          'Saved Restaurants',
          style: KTextStyle.titleTextStyle,
        ),
        automaticallyImplyLeading: false, // Disable back button
      ),

      body: loading
      ? Center(child: CircularProgressIndicator(),)
      : savedRestaurants.isNotEmpty
      ? SingleChildScrollView(
        child: Column(
          // Align the text in the center of the screen
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: savedRestaurants.map((e) => SavedRestaurantFuture(future: e),).toList() // too long when database is big
        ),
      )
      : Center(child: Text('You do not have any saved restaurants'),)
    );
  }
}
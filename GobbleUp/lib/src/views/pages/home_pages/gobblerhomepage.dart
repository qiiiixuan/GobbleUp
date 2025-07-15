import 'package:GobbleUp/src/data/constants.dart';
import 'package:GobbleUp/src/services/auth_service.dart';
import 'package:GobbleUp/src/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../widgets/restaurantcard_widget.dart';

class GobblerHomePage extends StatefulWidget {
  const GobblerHomePage({super.key});

  @override
  State<GobblerHomePage> createState() => _GobblerHomePageState();
}

class _GobblerHomePageState extends State<GobblerHomePage> {
  final User? user = AuthService().currentUser;

  // Todo: Handle null cases (when getRandomRestaurant returns Future<null>)
  // Todo: How to ensure second random is different from first random?
  List<Future<Map<String, dynamic>?>?> restaurantFutures = [
    DatabaseService().getRandomRestaurant(gobblerUid: AuthService().currentUser?.uid),
    DatabaseService().getRandomRestaurant(gobblerUid: AuthService().currentUser?.uid),
  ];

  // Reload and fetch new restaurants
  // Todo: buggy index 0 or 1?
  void _loadNewRestaurants() {
    setState(() {
      Future<Map<String, dynamic>?>? randomRestaurant = restaurantFutures[0];
      restaurantFutures = [
        randomRestaurant,
        DatabaseService().getRandomRestaurant(gobblerUid: user!.uid),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
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
          'Gobbler',
          style: KTextStyle.titleTextStyle,
        ),
        automaticallyImplyLeading: false, // Disable back button
      ),

      // This is the hinge like cards 
      body: restaurantFutures[0] != null ? CardSwiper(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        cardsCount: restaurantFutures.length,
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
          return RestaurantCardFuture(future: restaurantFutures[index]!);
        },
        onEnd: () => setState(() {
          _loadNewRestaurants(); // Load new restaurants
        }),
        isLoop: true,
        onSwipe: _onSwipe,
      ) : Text("You have run out of food"),
    );
  }

  // Handle swipe actions
  Future<bool> _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) async{

    // Get current length of savedRestaurants
    DataSnapshot? savedRestaurants = await DatabaseService().read(path: 'Gobbler/${user!.uid}/savedRestaurants');
    int length = savedRestaurants != null ? savedRestaurants.children.length : 0;

    // Swiped right
    if (direction.name == 'right') {
      Map<String, dynamic>? restaurantData = await restaurantFutures[previousIndex];
      if (restaurantData != null) {
        // Save restaurant data
        await DatabaseService().update(
            path: 'Gobbler/${user!.uid}/savedRestaurants',
            data: {'listItem${length + 1}' : restaurantData['uid']},
        );
      }
      // Swiped left
    } else if (direction.name == 'left') {
      // Do nothing
    }
    return true; 
  }
}

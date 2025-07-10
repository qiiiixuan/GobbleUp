import 'package:GobbleUp/src/data/constants.dart';
import 'package:GobbleUp/src/services/auth_service.dart';
import 'package:GobbleUp/src/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../widgets/restaurantcard_widget.dart';

class GobblerHomePage extends StatefulWidget {
  const GobblerHomePage({super.key});

  @override
  State<GobblerHomePage> createState() => _GobblerHomePageState();
}

class _GobblerHomePageState extends State<GobblerHomePage> {
  int currentIndex = 0;
  final User? user = AuthService().currentUser;

   List<Future<Map<String, dynamic>?>> restaurantFutures = [
    DatabaseService().getRandomRestaurant(),
    DatabaseService().getRandomRestaurant(),
    DatabaseService().getRandomRestaurant(),
    DatabaseService().getRandomRestaurant(),
  ];

  //Reload and fetch new restaurants
  void _loadNewRestaurants() {
    setState(() {
      restaurantFutures = [
        DatabaseService().getRandomRestaurant(),
        DatabaseService().getRandomRestaurant(),
        DatabaseService().getRandomRestaurant(),
        DatabaseService().getRandomRestaurant(),
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
      body: CardSwiper(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        cardsCount: restaurantFutures.length,
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
          return RestaurantCardFuture(future: restaurantFutures[index]);
        },
        onEnd: () => setState(() {
          currentIndex = 0; // Reset index when swiping ends
          _loadNewRestaurants(); // Load new restaurants
        }),
        isLoop: true,
        onSwipe: _onSwipe,
      ),
    );
  }

  Future<bool> _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) async{
    // Handle swipe actions if needed
    print('yes');
    if (direction.name == 'right') {
      // Swiped right
      print('Swiped right on index: $previousIndex');
      Map<String, dynamic>? restaurantData = await restaurantFutures[previousIndex!];
      if (restaurantData != null) {
        // Save resturant data
        //TODO: Change savedResturants to a list of uids
        print(restaurantData['uid']);
        var savedResturants =  await DatabaseService().read(path: 'Gobbler/${user!.uid}/savedResturants');
        // savedResturants.add(restaurantData['uid']);
        // await DatabaseService().update(path: 'Gobbler/${user!.uid}/savedResturants', data: {
        //   'savedResturants': savedResturants,
        // });
        // print('Saved restaurant: ${restaurantData['uid']}');
      }
      print(restaurantFutures[previousIndex!]);
    } else if (direction.name == 'left') {
      // Swiped left
      print('Swiped left on index: $previousIndex');
    
    }
    return true; 
  }
}

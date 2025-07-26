import 'dart:math';
import 'package:GobbleUp/src/views/pages/gobbler_pages/gobblerfilterpage.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  // Create data
  Future<void> create({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.set(data);
  }

  // Randomly generate a card deck of restaurants for each Gobbler
  Future<List<Future<Map<String, dynamic>>>> getRandomRestaurants({required String? gobblerUid}) async {
    final DatabaseReference ref = _firebaseDatabase.ref('Gobbled');
    final DataSnapshot snapshot = await ref.get();
    List<Future<Map<String, dynamic>>> cardDeck = [];
    Map<dynamic, dynamic> data;
    List<dynamic> keys;
    dynamic randomKey;
    Map<String, dynamic> restaurantData;
    
    if (snapshot.exists && gobblerUid != null) {
      data = snapshot.value as Map<dynamic, dynamic>;

      // Obtain and remove saved restaurants from card deck
      final DataSnapshot? savedRestaurants = await DatabaseService().read(path: 'Gobbler/$gobblerUid/savedRestaurants');
      final int length = savedRestaurants != null ? savedRestaurants.children.length : 0;
      for (int counter = 0; counter < length; counter++) {
        var savedUid = savedRestaurants?.children.elementAt(counter).value as dynamic;
        if (savedUid != null && data[savedUid] != null) {
          data.remove(savedUid);
        }
      }

      // Randomly arrange restaurants in deck (will take to long once database is big)
      while (data.isNotEmpty) {
        keys = data.keys.toList();
        randomKey = keys[Random().nextInt(keys.length)];
        restaurantData = Map<String, dynamic>.from(data[randomKey]);
        cardDeck.add(Future.value(restaurantData));
        data.remove(randomKey);
      }
    }
    return cardDeck;
  }

  // Obtain current restaurant data
  Future<Map<String, dynamic>?> getRestaurant({required String gobbledUid}) async {
    final DatabaseReference ref = _firebaseDatabase.ref('Gobbled/$gobbledUid');
    final DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final restaurantData = Map<String, dynamic>.from(data);
      return restaurantData;
    }
    return null;
  }

  // Obtain list of saved restaurant data for each Gobbler
  Future<List<Future<Map<String, dynamic>>>> getSavedRestaurants({required String? gobblerUid}) async {
    final DatabaseReference ref = _firebaseDatabase.ref('Gobbled');
    final DataSnapshot snapshot = await ref.get();
    List<Future<Map<String, dynamic>>> restaurants = [];
    Map<dynamic, dynamic> data;
    Map<String, dynamic> restaurantData;

    if (snapshot.exists && gobblerUid != null) {
      data = snapshot.value as Map<dynamic, dynamic>;

      final DataSnapshot? savedRestaurants = await DatabaseService().read(path: 'Gobbler/$gobblerUid/savedRestaurants');
      final int length = savedRestaurants != null ? savedRestaurants.children.length : 0;
      for (int counter = 0; counter < length; counter++) {
        restaurantData = Map<String, dynamic>.from(data[savedRestaurants?.children.elementAt(counter).value]);
        restaurants.add(Future.value(restaurantData));
      }
    }
    return restaurants;
  }

  // Read data
  Future<DataSnapshot?> read({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }

  // Update data
  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }

  // Delete data
  Future<void> delete({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.remove();
  }
}
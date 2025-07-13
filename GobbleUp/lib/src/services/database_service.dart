import 'dart:math';
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

  // Randomly generate restaurant for gobbler
  Future<Map<String, dynamic>?>? getRandomRestaurant({required String? gobblerUid}) async {
    final DatabaseReference ref = _firebaseDatabase.ref('Gobbled');
    final DataSnapshot snapshot = await ref.get();
    String? savedUid;
    
    if (snapshot.exists && gobblerUid != null) {
      final data = snapshot.value as Map<dynamic, dynamic>;

      // Todo: Obtain and remove saved restaurants from card deck
      // final DataSnapshot? savedRestaurants = await DatabaseService().read(path: 'Gobbler/$gobblerUid/savedRestaurants');
      // final int length = savedRestaurants != null ? savedRestaurants.children.length : 0;
      // for (int counter = 0; counter < length; counter++) {
      //   savedUid = savedRestaurants?.children.elementAt(counter).key;
      //   if (data[savedUid] != null) {
      //     data.remove(savedUid);
      //   }
      // }

      // Randomly pick a restaurant from deck
      final keys = data.keys.toList();
      final randomKey = keys[Random().nextInt(keys.length)];
      final restaurantData = Map<String, dynamic>.from(data[randomKey]);
      return restaurantData;
    }
    return null;
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
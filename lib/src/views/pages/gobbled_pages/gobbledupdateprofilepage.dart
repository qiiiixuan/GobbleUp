import 'package:GobbleUp/src/data/constants.dart';
import 'package:GobbleUp/src/services/database_service.dart';
import 'package:GobbleUp/src/views/pages/gobbled_pages/gobbledrootpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:GobbleUp/src/services/auth_service.dart';


class GobbleUpDateProfilePage extends StatefulWidget {
 const GobbleUpDateProfilePage({super.key});


 @override
 State<GobbleUpDateProfilePage> createState() => _GobbleUpDateProfilePageState();
}


class _GobbleUpDateProfilePageState extends State<GobbleUpDateProfilePage> {


 //Data to be changed to
 TextEditingController emailController = TextEditingController();
 TextEditingController nameController = TextEditingController();
 TextEditingController MRTController = TextEditingController();
 TextEditingController signatureController = TextEditingController();
 TextEditingController environmentController = TextEditingController();
 TextEditingController descriptionController = TextEditingController();
 TextEditingController ImageController = TextEditingController();
 TextEditingController InstagramController = TextEditingController();
 TextEditingController FacebookController = TextEditingController();






 String? selectedPriceRange;
 String? selectedCuisine;
 Map<String, dynamic>? restaurant;


 // Dropdown menu items (more to be added)
 List<String> cuisines = [
   'Western',
   'Chinese',
   'Italian',
   'Indian',
   'Mexican',
   'Japanese',
   'Thai',
   'Vegetarian',
   'Other',
 
 ];


 List<String> priceRange = [
   'Less than \$10',
   '\$10 - \$20',
   '\$20 - \$30',
   '\$30 - \$40',
   'More than \$40',
 
 ];




 // Set text controllers with current restaurant data
 void setTextControllers()  async{
  
     restaurant = await DatabaseService().getRestaurant(gobbledUid: AuthService().currentUser!.uid);
      if (restaurant != null) {
       nameController.text = restaurant!['username'] ?? '';
       emailController.text = restaurant!['email'] ?? '';
       MRTController.text = restaurant!['MRT'] ?? '';
       signatureController.text = restaurant!['SignatureDish'] ?? '';
       environmentController.text = restaurant!['Environment'] ?? '';
       descriptionController.text = restaurant!['Description'] ?? '';
       ImageController.text = restaurant!['Image'] ?? '';
       selectedCuisine = restaurant!['Cuisine'];
       selectedPriceRange = restaurant!['PriceRange'];
       InstagramController.text = restaurant!['Instagram'] ?? '';
       FacebookController.text = restaurant!['Facebook'] ?? '';
     }
 }


 @override
 void initState() {
   super.initState();
   setTextControllers();
 }




 // Update user profile
 void update() async {
   try {
     await DatabaseService().update( path: 'Gobbled/${authService.value.currentUser!.uid}',
     data: {
       'username': nameController.text,
       'email': emailController.text,
       'MRT': MRTController.text,
       'SignatureDish': signatureController.text,
       'Environment': environmentController.text,
       'Description': descriptionController.text,
       'Cuisine': selectedCuisine,
       'PriceRange': selectedPriceRange,
       'Image': ImageController.text,
       'Instagram': InstagramController.text,
       'Facebook': FacebookController.text,


     }
     );
     Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
       MaterialPageRoute(builder: (_) => const GobbledRootPage()),
       (route) => false,
     );
   } on FirebaseAuthException catch (e) {
     // Handle error
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text('Update failed: ${e.message}'),       
         ),
     );
   }
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Update Profile Page'),
       automaticallyImplyLeading: true,
     ),
     body: SingleChildScrollView(
       padding: EdgeInsets.all(16.0),
       child: Column(
         children: [
           Center(
             child: Hero(
               tag: 2,
               child: Image(
                 image: AssetImage('assets/images/gobbled.png'),
                 height: 150.0,
                 width: 150.0,
               ),
             ),
           ),


           const SizedBox(height: 20.0),


           SizedBox(
             width: double.infinity,
             child: Text(
               "Restaurant Details:",
               style: KTextStyle.titleTextStyle,
               textAlign: TextAlign.start,
             ),
           ),


           const SizedBox(height: 20.0),


           TextField(
             controller: nameController,
             decoration: InputDecoration(
               labelText: 'Restaurant Name',
             ),
             autofillHints: restaurant?['username'],
           ),


           const SizedBox(height: 20.0),


           TextField(
             controller: emailController,
             decoration: InputDecoration(
               labelText: 'Email',
             ),
           ),


           const SizedBox(height: 20.0),


           SizedBox(
             width: double.infinity,
             child: DropdownButton(
               alignment: AlignmentDirectional.centerStart,
               hint: Container(
                 alignment: Alignment.centerLeft,
                 child: Text('Cuisine'),
               ),
               value: selectedCuisine,
               items: cuisines.map((value) => DropdownMenuItem(
                 value: value,
                 child: Text(value),
               )).toList(),
               onChanged: (String? value) {
                 setState(() {
                   selectedCuisine = value;
                 });
               },
             ),
           ),


           const SizedBox(height: 20.0),


           TextField(
             controller: MRTController,
             decoration: InputDecoration(
               labelText: 'Nearest MRT Station',
             ),
          ),


          const SizedBox(height: 20.0),


           SizedBox(
             width: double.infinity,
             child: DropdownButton(
               alignment: AlignmentDirectional.centerStart,
               hint: Container(
                 alignment: Alignment.centerLeft,
                 child: Text('Price Range'),
               ),
               value: selectedPriceRange,
               items: priceRange.map((value) => DropdownMenuItem(
                 value: value,
                 child: Text(value),
               )).toList(),
               onChanged: (String? value) {
                 setState(() {
                   selectedPriceRange = value;
                 });
               },
             ),
           ),


           const SizedBox(height: 20.0),


           TextField(
             controller: signatureController,
             decoration: InputDecoration(
               labelText: 'What is your signature dish?',
             ),
           ),
          
           const SizedBox(height: 20.0),


           TextField(
             controller: environmentController,
             decoration: InputDecoration(
               labelText: 'What is your environment like?',
             ),
           ),


           const SizedBox(height: 20.0),


           TextField(
             controller: descriptionController,
             decoration: InputDecoration(
               labelText: 'Describe your restaurant in 5 words or less',
             ),
           ),


           const SizedBox(height: 20.0),


           TextField(
             controller: ImageController,
             decoration: InputDecoration(
               labelText: 'Image URL ending with .jgp / .png (leave blank for default)',
             ),
           ),




           const SizedBox(height: 20.0),


           TextField(
             controller: InstagramController,
             decoration: InputDecoration(
               labelText: 'Instagram URL (leave blank for default)',
             ),
           ),


           const SizedBox(height: 20.0),


           TextField(
             controller: FacebookController,
             decoration: InputDecoration(
               labelText: 'Facebook URL (leave blank for default)',
             ),
           ),


           const SizedBox(height: 50.0),


           ElevatedButton(
             onPressed: () {
               update();
             },
             style: KButtonStyle.elevatedButtonStyle,
             child: Text(
               'Update',
               style: KTextStyle.buttonTextStyle,
             ),
           ),
         ],
       ),
     ),
   );
 }
}

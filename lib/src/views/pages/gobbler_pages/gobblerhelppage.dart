import 'package:flutter/material.dart';
import 'package:GobbleUp/src/data/constants.dart';


class GobblerHelpPage extends StatelessWidget {
 const GobblerHelpPage({super.key});


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         onPressed: () {
           Navigator.pop(context);
         },
       ),


       title: Text("Gobbler Help Page"),
       backgroundColor: Color(0xFFFF8989), // Replace with your desired color
       automaticallyImplyLeading: true,
     ),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             "Frequently Asked Questions",
             style: KTextStyle.titleTextStyle,
           ),
           SizedBox(height: 20),
           Text(
             "1. How does this app work?",
             style: KTextStyle.normalTextStyleWithSize,
           ),
           SizedBox(height: 10),
           Text(
             "Each resturant card is Swipable! Simply swipe left to skip and right to save. There is a filter icon which allows you to set your filters to apply!",
             style: KTextStyle.normalTextStyle,
           ),
           SizedBox(height: 20),
           Text(
             "2. How to I checked my saves?",
             style: KTextStyle.normalTextStyleWithSize,
           ),
           SizedBox(height: 10),
           Text(
             "You can go to the saved section to view all your saved restaurants.",
             style: KTextStyle.normalTextStyle,
           ),
         ],
       ),
     ),
   );
 }
}

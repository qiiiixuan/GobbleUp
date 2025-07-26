
import 'package:GobbleUp/src/views/widgets/selectbutton.dart';
import 'package:flutter/material.dart';
import 'package:GobbleUp/src/data/constants.dart';


class WelcomeHelpPage extends StatelessWidget {
 const WelcomeHelpPage({super.key});


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


       title: Text("Welcome Help Page"),
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
             "1. What is Gobble Up?",
             style: KTextStyle.normalTextStyleWithSize,
           ),
           SizedBox(height: 10),
           Text(
             "GobbleUp is a platform the connects users with restaurants in a fun and engaging way! Users can swipe through restaurant cards, save their favorites, and apply filters to find the best dining options.",
             style: KTextStyle.normalTextStyle,
           ),
           SizedBox(height: 20),
           Text(
             "2. What are Gobblers / Gobbled ?",
             style: KTextStyle.normalTextStyleWithSize,
           ),
           SizedBox(height: 10),
           Text(
             "Gobblers are users who want to find restaurants, while Gobbled are restaurant owners who want to promote their restaurants.",
             style: KTextStyle.normalTextStyle,
           ),
           SizedBox(height: 20),
           Text(
             "3. Are the features free?",
             style: KTextStyle.normalTextStyleWithSize,
           ),
           SizedBox(height: 10),
           Text(
             "Certainly! All features are for the benefit of the community.",
             style: KTextStyle.normalTextStyle,
           ),
         ],
       ),
     ),
   );
 }
}



import 'package:flutter/material.dart';
import 'package:GobbleUp/src/data/constants.dart';


class GobbledHelpPage extends StatelessWidget {
 const GobbledHelpPage({super.key});


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


       title: Text("Gobbled Help Page"),
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
             "1. How do I edit my profile?",
             style: KTextStyle.normalTextStyleWithSize,
           ),
           SizedBox(height: 10),
           Text(
             "Simply click on the profile icon at the bottom right corner and you should see your current profile card. If you scroll down, you will see an \"Edit Profile\" button. Click on it to edit your profile.",
             style: KTextStyle.normalTextStyle,
           ),
           SizedBox(height: 20),
           Text(
             "2. When I update my profile, must I write my bio from scratch?",
             style: KTextStyle.normalTextStyleWithSize,
           ),
           SizedBox(height: 10),
           Text(
             "No, we have eased the hassle off you! The text fields will be pre-filled with your current profile information. You can simply edit the fields you want to change.",
             style: KTextStyle.normalTextStyle,
           ),
         ],
       ),
     ),
   );
 }
}



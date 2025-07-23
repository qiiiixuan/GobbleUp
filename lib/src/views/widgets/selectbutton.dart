import 'package:flutter/material.dart';
import 'package:GobbleUp/src/data/constants.dart';

class SelectButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
                  alignment: Alignment.center, // aslign text to center
                  decoration: BoxDecoration(
                    // if the button is selected, use a gradient background
                    gradient: isSelected ?
                    LinearGradient(
                      colors: [
                        Color(0xFFFF6666),
                        Color(0xFFFF9999),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ) : null,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: isSelected ?
                     Border.all(
                      color: Color.fromARGB(255, 246, 176, 176),
                      width: 2,
                    ) : null,
      
                  ),
                  child: Text(
                    text,
                    style: KTextStyle.normalTextStyle.copyWith(
                       // if the button is selected, use white text color
                      color: isSelected ?
                       Colors.white : Colors.black,
                       
                      fontSize: 16,
                     
                    ),
                  ),
                ),
    );
  }
}
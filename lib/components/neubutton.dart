import 'package:flutter/material.dart';

class Neubutton extends StatelessWidget {
  final VoidCallback ontap; // Callback for the tap event
  final IconData icons; // Icon to display
  final String label; // Label to display below the button
  final bool isActive; // Flag for active state
  final Color activeBorderColor; // Border color when active
  final Color inactiveBorderColor; // Border color when inactive

  const Neubutton({
    super.key,
    required this.ontap,
    required this.icons,
    required this.label,
    this.isActive = false,
    this.activeBorderColor = Colors.blue,
    this.inactiveBorderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            height: 80,
            width: 80,
            child: Icon(
              icons,
              size: 25,
              color: Colors.grey.shade400,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(251, 39, 10, 44),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isActive ? activeBorderColor : inactiveBorderColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(131, 29, 23, 59),
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color.fromARGB(255, 35, 16, 86),
                  offset: const Offset(5, 4),
                  blurRadius: 9,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

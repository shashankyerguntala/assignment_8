import 'package:flutter/material.dart';

class FindLocationDetailsCard extends StatelessWidget {
  const FindLocationDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.location_on,
            size: 48,
            color: Color.fromARGB(255, 13, 43, 124),
          ),
          SizedBox(height: 12),
          Text(
            'Find Location Details',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 13, 43, 124),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select a country and enter a zip code to get detailed location information',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

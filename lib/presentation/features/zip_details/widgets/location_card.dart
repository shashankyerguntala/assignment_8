import 'package:assignment_8/domain/entity/zipcode_entity.dart';
import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final ZipcodeEntity data;
  const LocationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, color: Color(0xFF1B2951), size: 60),
          const SizedBox(height: 12),
          Text(
            data.placeName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B2951),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${data.state}, ${data.country}",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            "Postal Code: ${data.postCode}",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZipCodeTextfield extends StatelessWidget {
  final TextEditingController zipController;
  const ZipCodeTextfield({super.key, required this.zipController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          controller: zipController,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Color.fromARGB(255, 13, 43, 124),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter zip code",
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.pin_drop,
              color: Color.fromARGB(255, 13, 43, 124),
            ),
          ),
        ),
      ),
    );
  }
}

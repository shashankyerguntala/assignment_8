import 'package:assignment_8/presentation/features/home_feature/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class SelectCountryField extends StatefulWidget {
  final HomeBloc homeBloc;
  final Map<String, String> countries;
  const SelectCountryField({
    super.key,
    required this.homeBloc,
    required this.countries,
  });

  @override
  State<SelectCountryField> createState() => _SelectCountryFieldState();
}

class _SelectCountryFieldState extends State<SelectCountryField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: DropdownButtonFormField<String>(
          dropdownColor: Color.fromRGBO(248, 248, 248, 1),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Choose a country",
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.flag,
              color: Color.fromARGB(255, 13, 43, 124),
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Color.fromARGB(255, 13, 43, 124),
            fontWeight: FontWeight.w500,
          ),
          onChanged: (value) {
            widget.homeBloc.add(SelectCountryEvent(value!));
          },
          items: widget.countries.keys.map((country) {
            return DropdownMenuItem(
              value: country,
              child: Text(
                country,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Color.fromARGB(255, 31, 65, 161),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

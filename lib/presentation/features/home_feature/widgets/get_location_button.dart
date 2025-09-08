import 'package:assignment_8/core/Navigation/routes/routes.gr.dart';
import 'package:assignment_8/presentation/features/zip_details/bloc/zip_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class GetLocationButton extends StatefulWidget {
  final ZipBloc zipBloc;
  final String? selectedCountry;
  final TextEditingController zipController;

  const GetLocationButton({
    super.key,
    required this.zipBloc,
    required this.selectedCountry,
    required this.zipController,
  });

  @override
  State<GetLocationButton> createState() => _GetLocationButtonState();
}

class _GetLocationButtonState extends State<GetLocationButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.selectedCountry == null ||
            widget.zipController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.white),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Please select a country and enter a zip code",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.orange.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
          return;
        }

        widget.zipBloc.add(
          GetDetailsEvent(
            country: widget.selectedCountry!,
            zipCode: widget.zipController.text.trim(),
          ),
        );

        context.pushRoute(ZipcodeDetailsRoute());
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color.fromARGB(255, 13, 43, 124),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 20),
          SizedBox(width: 8),
          Text(
            'Get Location Details',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

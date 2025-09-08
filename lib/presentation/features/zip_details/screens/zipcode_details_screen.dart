import 'package:assignment_8/presentation/features/zip_details/bloc/zip_bloc.dart';
import 'package:assignment_8/presentation/features/zip_details/widgets/info_card.dart';
import 'package:assignment_8/presentation/features/zip_details/widgets/location_card.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ZipcodeDetailsScreen extends StatefulWidget {
  const ZipcodeDetailsScreen({super.key});

  @override
  State<ZipcodeDetailsScreen> createState() => _ZipcodeDetailsScreenState();
}

class _ZipcodeDetailsScreenState extends State<ZipcodeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        title: const Text(
          "Location Details",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF1B2951),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ZipBloc, ZipState>(
        builder: (context, state) {
          if (state is ZipLoading || state is ZipInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ZipCodeDetails) {
            final data = state.data;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  LocationCard(data: data),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      InfoCard(
                        title: "Latitude",
                        value: data.latitude,
                        icon: Icons.explore,
                      ),

                      const SizedBox(width: 16),
                      InfoCard(
                        title: "Longitude",
                        value: data.longitude,
                        icon: Icons.explore_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is ZipError) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: const Text(
                "Error while fetching location info.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF1B2951),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

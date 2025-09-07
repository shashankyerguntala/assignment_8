import 'package:assignment_8/presentation/features/zip_details/bloc/zip_bloc.dart';
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
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Color(0xFF1B2951),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading location details...',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF1B2951),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ZipCodeDetails) {
            final data = state.data;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF1B2951),
                          size: 60,
                        ),
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
                  ),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      _buildInfoCard("Latitude", data.latitude, Icons.explore),
                      const SizedBox(width: 16),
                      _buildInfoCard(
                        "Longitude",
                        data.longitude,
                        Icons.explore_outlined,
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
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Error while fetching location info.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF1B2951),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF1B2951), size: 28),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2951),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

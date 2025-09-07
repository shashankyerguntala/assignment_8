import 'package:assignment_8/core/Navigation/routes/routes.gr.dart';
import 'package:assignment_8/presentation/features/home_feature/bloc/home_bloc.dart';
import 'package:assignment_8/presentation/features/zip_details/bloc/zip_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Connectivity connectivity = Connectivity();
  late final Stream<List<ConnectivityResult>> connectivityStream;
  final TextEditingController zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadCountriesEvent());
    connectivityStream = connectivity.onConnectivityChanged;

    connectivityStream.listen((List<ConnectivityResult> resultList) {
      final result = resultList.isNotEmpty
          ? resultList.first
          : ConnectivityResult.none;
      final isConnected = result != ConnectivityResult.none;
      final message = isConnected ? "You are online" : "No internet connection";

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  isConnected ? Icons.wifi : Icons.wifi_off,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(message),
              ],
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: isConnected
                ? Colors.green.shade600
                : Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Zip Code Finder',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color.fromARGB(255, 13, 43, 124),
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Color.fromARGB(255, 13, 43, 124),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading countries...',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 13, 43, 124),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is HomeLoaded) {
                final countries = state.country;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
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
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Select Country',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 43, 124),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
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
                            context.read<HomeBloc>().add(
                              SelectCountryEvent(value!),
                            );
                          },
                          items: countries.keys.map((country) {
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
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Zip Code',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 43, 124),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
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
                    ),

                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: () {
                        if (state.selectedCountry == null ||
                            zipController.text.trim().isEmpty) {
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

                        final zipBloc = context.read<ZipBloc>();
                        zipBloc.add(
                          GetDetailsEvent(
                            country: state.selectedCountry!,
                            zipCode: zipController.text.trim(),
                          ),
                        );

                        context.pushRoute(ZipcodeDetailsRoute());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color.fromARGB(255, 13, 43, 124),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
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
                    ),

                    const Spacer(),

                    const Text(
                      'Powered by Zip Code API',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    'Unknown state',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 13, 43, 124),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

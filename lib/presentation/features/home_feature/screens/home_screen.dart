import 'package:assignment_8/presentation/features/home_feature/bloc/home_bloc.dart';
import 'package:assignment_8/presentation/features/home_feature/widgets/find_location_details_card.dart';
import 'package:assignment_8/presentation/features/home_feature/widgets/get_location_button.dart';
import 'package:assignment_8/presentation/features/home_feature/widgets/select_country_field.dart';
import 'package:assignment_8/presentation/features/home_feature/widgets/zip_code_textfield.dart';
import 'package:assignment_8/presentation/features/zip_details/bloc/zip_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool isvalidated = false;
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
    });
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
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 13, 43, 124),
                  ),
                );
              } else if (state is HomeLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FindLocationDetailsCard(),

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

                    SelectCountryField(
                      homeBloc: context.read<HomeBloc>(),
                      countries: state.country,
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

                    ZipCodeTextfield(zipController: zipController),

                    const SizedBox(height: 32),

                    GetLocationButton(
                      zipBloc: context.read<ZipBloc>(),
                      selectedCountry: state.selectedCountry,
                      zipController: zipController,
                    ),

                    const Spacer(),

                    const Text(
                      'Powered by Shash',
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
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
      ),
    );
  }
}

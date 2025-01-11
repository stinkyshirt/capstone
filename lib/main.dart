import 'dart:ui';

import 'package:capstone/conveyance.dart';
import 'package:capstone/premium.dart';
import 'package:capstone/recording.dart';
import 'package:capstone/title.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: "QuickCalc",
          theme: ThemeData(
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                color: Color(0xFF030303),
                fontSize: 52.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 800),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              displaySmall: TextStyle(
                color: Color(0xFF030303),
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic,
                fontVariations: [
                  FontVariation('wght', 620),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              titleMedium: TextStyle(
                color: Color(0xFF030303),
                fontSize: 24.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              ),
              labelMedium: TextStyle(
                fontSize: 14.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              ),
              headlineMedium: TextStyle(
                color: Color(0xFF030303),
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 700),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF030303),
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              titleTextStyle: TextStyle(
                color: Color(0xFF030303),
                fontSize: 24.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 725),
                ],
              ),
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Color(0xFF030303),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD6D6D6),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD6D6D6),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD6D6D6),
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 250),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              labelStyle: const TextStyle(
                color: Color(0xFFD3D3D3),
                fontSize: 14.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            segmentedButtonTheme: SegmentedButtonThemeData(
                style: ButtonStyle(

                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 6.0),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xFFD3D3D3))
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFFD3D3D3);
                    }
                    return Colors.white;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF030303);
                    }
                    return const Color(0xFFD3D3D3);
                  }),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Color(0xFF030303),
                      fontSize: 11,
                      fontFamily: 'Montserrat',
                      fontVariations: [
                        FontVariation('wght', 700),
                      ],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
            ),

            dividerTheme: const DividerThemeData(
              thickness: 2.0,
              color: Color(0xFFD3D3D3),
            ),
            dialogTheme: const DialogTheme(
              elevation: 36.0,
              shadowColor: Colors.black,
              titleTextStyle: TextStyle(
                color: Color(0xFF030303),
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 700),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              contentTextStyle: TextStyle(
                color: Color(0xFF030303),
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 12.0),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF4E6A8F)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                  const TextStyle( // ACCOUNT TITLE
                    color: Color(0xFF030303),
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontVariations: [
                      FontVariation('wght', 700),
                    ],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white;
                }
                return const Color(0xFF4E6A8F);
              }),
              trackColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color(0xFF4E6A8F);
                }
                return Colors.white;
              }),
            ),
            listTileTheme: const ListTileThemeData(
              titleTextStyle: TextStyle(
                color: Color(0xFF030303),
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 18.0, vertical: 0),
            ),
            iconTheme: const IconThemeData(
              size: 20,
              color: Color(0xFF030303),
            ),
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue,
                brightness: Brightness.light),
          ),
          darkTheme: ThemeData(
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 52.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 800),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              displaySmall: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic,
                fontVariations: [
                  FontVariation('wght', 620),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              titleMedium: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 24.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              ),
              labelMedium: TextStyle(
                fontSize: 14.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              ),
              headlineMedium: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 700),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              bodyMedium: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              titleTextStyle: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 24.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 725),
                ],
              ),
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Color(0xFFFFFFFF),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(
                  color: Color(0xFF4E4E4E),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(
                  color: Color(0xFF4E4E4E),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(
                  color: Color(0xFF4E4E4E),
                ),
              ),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 250),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              labelStyle: const TextStyle(
                color: Color(0xFF4E4E4E),
                fontSize: 14.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            segmentedButtonTheme: SegmentedButtonThemeData(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xFF4E4E4E))
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFF4E4E4E);
                    }
                    return Colors.black;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xFFFFFFFF);
                    }
                    return const Color(0xFF4E4E4E);
                  }),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 11,
                      fontFamily: 'Montserrat',
                      fontVariations: [
                        FontVariation('wght', 700),
                      ],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
            ),
            dividerTheme: const DividerThemeData(
              thickness: 2.0,
              color: Color(0xFF4E4E4E),
            ),
            dialogTheme: const DialogTheme(
              elevation: 36.0,
              shadowColor: Colors.black,
              titleTextStyle: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 700),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              contentTextStyle: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF4E6A8F)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                  const TextStyle( // ACCOUNT TITLE
                    color: Color(0xFFFFFFFF),
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontVariations: [
                      FontVariation('wght', 700),
                    ],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) return Colors.white;
                return const Color(0xFF4E6A8F);
              }),
              trackColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color(0xFF4E6A8F);
                }
                return Colors.black;
              }),
            ),
            listTileTheme: const ListTileThemeData(
              titleTextStyle: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontVariations: [
                  FontVariation('wght', 500),
                ],
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 18.0, vertical: 0),
            ),
            iconTheme: const IconThemeData(
              size: 20,
              color: Color(0xFFFFFFFF),
            ),
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.light,
          home: const TitlePage(), // TODO: change back to title page and FIX !!!!
        );
      },
    );
  }

}



class MainBase extends StatefulWidget {
  const MainBase({super.key});

  @override
  _MainBaseState createState() => _MainBaseState();
}

class _MainBaseState extends State<MainBase> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const ConveyancePage(),
    const RecordingPage(),
    const PremiumPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _pages[index.abs() % _pages.length];
        },
      ),
    );
  }
}
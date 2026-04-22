import 'dart:ui';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import '../widgets/add_drink_bottom_sheet.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const DashboardScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBody: false,
      // --- ANIMAZIONE PREMIUM TRA LE PAGINE ---
      // --- NUOVA ANIMAZIONE PREMIUM (MANTIENE IN VITA LE PAGINE) ---
      body: Stack(
        children: List.generate(_pages.length, (index) {
          final isActive = _currentIndex == index;
          
          return IgnorePointer(
            ignoring: !isActive, // Blocca i tap sulla pagina nascosta
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 350),
              curve: isActive ? Curves.easeOutCubic : Curves.easeInCubic,
              opacity: isActive ? 1.0 : 0.0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 350),
                curve: isActive ? Curves.easeOutCubic : Curves.easeInCubic,
                scale: isActive ? 1.0 : 0.97,
                child: _pages[index],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- PILLOLA DI NAVIGAZIONE CON SLIDER ANIMATO ---
              Container(
                height: 60,
                width: 120, // Larghezza fissa per precisione millimetrica
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : const Color(0xFFEBEBEB).withOpacity(0.98),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 8)),
                  ],
                ),
                child: Stack(
                  children: [
                    // --- IL TASTO BIANCO CHE SCIVOLA ---
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                      alignment: _currentIndex == 0 
                          ? Alignment.centerLeft 
                          : Alignment.centerRight,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[700] : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
                          ],
                        ),
                      ),
                    ),
                    // --- LE ICONE SOPRA LO SLIDER ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavIcon(0, Icons.data_usage_rounded, isDark),
                        _buildNavIcon(1, Icons.stacked_line_chart_rounded, isDark),
                      ],
                    ),
                  ],
                ),
              ),

              // --- TASTO + ARANCIONE ---
              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                child: _currentIndex == 0
                    ? Container(
                        key: const ValueKey('add_btn'),
                        margin: const EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: const AddDrinkBottomSheet(),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.orange[600],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6)),
                              ],
                            ),
                            child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(int index, IconData icon, bool isDark) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        child: AnimatedScale(
          scale: isSelected ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            icon,
            color: isSelected 
                ? (isDark ? Colors.white : Colors.black) 
                : (isDark ? Colors.white38 : Colors.black38),
            size: 24,
          ),
        ),
      ),
    );
  }
}
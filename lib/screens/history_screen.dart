import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart' hide TextDirection; // <-- AGGIUNGI hide TextDirection
import '../providers/app_providers.dart';
import '../utils/bac_calculator.dart';
import '../l10n/app_localizations.dart';

// --- CUSTOM PAINTER PER DISEGNARE LE EMOJI SUL GRAFICO ---
class DrinkDotPainter extends FlDotPainter {
  final String emoji;
  DrinkDotPainter(this.emoji);

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final textSpan = TextSpan(text: emoji, style: const TextStyle(fontSize: 16));
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    // Centriamo l'emoji orizzontalmente e la alziamo leggermente sopra la linea
    textPainter.paint(
      canvas,
      Offset(offsetInCanvas.dx - (textPainter.width / 2), offsetInCanvas.dy - textPainter.height - 4),
    );
  }

  @override
  Size getSize(FlSpot spot) => const Size(20, 20);

  // --- FIX AGGIUNTI PER FL_CHART AGGIORNATO ---
  @override
  Color get mainColor => Colors.transparent;

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    return b; // Transizione base: passa subito al nuovo stato
  }

  @override
  List<Object?> get props => [emoji];
}

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  int? hoursSpan = 24; 
  DateTimeRange? selectedDateRange;

  final Map<int, String> presetSpans = {
    3: "3h",
    12: "12h",
    24: "24h",
  };

  // --- TRADUZIONI E ICONE ---
  String _getTranslatedDrinkName(String name, AppLocalizations loc) {
    final n = name.toLowerCase();
    if (n == 'birra' || n == 'beer') return loc.beer;
    if (n == 'vino' || n == 'wine') return loc.wine;
    if (n == 'prosecco') return loc.prosecco;
    if (n == 'shot') return loc.shot;
    if (n == 'amaro' || n == 'bitter') return loc.amaro;
    if (n == 'cocktail') return loc.cocktail;
    return name; 
  }

  IconData _getDrinkIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('birra') || n.contains('beer')) return Icons.sports_bar_rounded;
    if (n.contains('vino') || n.contains('wine') || n.contains('prosecco')) return Icons.wine_bar_rounded;
    if (n.contains('shot') || n.contains('amaro') || n.contains('bitter')) return Icons.liquor_rounded;
    if (n.contains('cocktail') || n.contains('spritz') || n.contains('gin') || n.contains('negroni')) return Icons.local_bar_rounded;
    return Icons.local_drink_rounded;
  }

  String _getDrinkEmoji(String name) {
    final n = name.toLowerCase();
    if (n.contains('birra') || n.contains('beer')) return "🍺";
    if (n.contains('vino') || n.contains('wine') || n.contains('prosecco')) return "🥂";
    if (n.contains('shot') || n.contains('amaro') || n.contains('bitter')) return "🥃";
    if (n.contains('cocktail') || n.contains('spritz') || n.contains('gin') || n.contains('negroni')) return "🍸";
    return "💧"; // Default
  }

  // --- LOGICA TEMPORALE CORRETTA E ASSOLUTA ---
  DateTime _getAxisStart() {
    if (hoursSpan != null) return DateTime.now().subtract(Duration(hours: hoursSpan!));
    return selectedDateRange!.start;
  }

  DateTime _getAxisEnd(dynamic drinks, dynamic user) {
    if (hoursSpan == null && selectedDateRange != null) {
      DateTime baseEnd = selectedDateRange!.end.add(const Duration(hours: 23, minutes: 59, seconds: 59));
      if (!baseEnd.isBefore(DateTime.now())) {
          return DateTime.now().add(const Duration(hours: 2));
      }
      return baseEnd;
    }

    double currentBac = BacCalculator.calculateCurrentBAC(drinks, user);
    if (currentBac <= 0) {
      return DateTime.now().add(const Duration(minutes: 60)); 
    }

    Duration timeToSober = BacCalculator.timeUntilSober(currentBac);
    int maxFutureMinutes = (hoursSpan! * 60) ~/ 1.5; 
    int futureMinutes = timeToSober.inMinutes + 30; 

    if (futureMinutes > maxFutureMinutes) {
      futureMinutes = maxFutureMinutes;
    }

    return DateTime.now().add(Duration(minutes: futureMinutes));
  }

  double _dateToX(DateTime date) => date.millisecondsSinceEpoch / 60000.0;
  DateTime _xToDate(double x) => DateTime.fromMillisecondsSinceEpoch((x * 60000).toInt());

  Future<void> _pickDateRange() async {
    final initialDateRange = selectedDateRange ??
        DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 3)),
          end: DateTime.now(),
        );

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: initialDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange, 
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
        hoursSpan = null; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final drinks = ref.watch(drinksProvider);
    final user = ref.watch(userProvider);
    final theme = Theme.of(context);

    final DateTime axisStart = _getAxisStart();
    final DateTime axisEnd = _getAxisEnd(drinks, user);
    final double totalAxisMinutes = axisEnd.difference(axisStart).inMinutes.toDouble();

    final DateTime endLimit = hoursSpan != null ? DateTime.now() : selectedDateRange!.end.add(const Duration(hours: 23, minutes: 59));
    
    // Filtriamo i drink per l'asse visibile e li ordiniamo cronologicamente (fondamentale per i punti del grafico)
    final displayedDrinks = drinks.where((d) {
      return d.timestamp.isAfter(axisStart) && d.timestamp.isBefore(endLimit);
    }).toList();
    displayedDrinks.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.historyTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...presetSpans.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(entry.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                      selected: hoursSpan == entry.key,
                      onSelected: (val) {
                        if (val) setState(() {
                          hoursSpan = entry.key;
                          selectedDateRange = null;
                        });
                      },
                      selectedColor: Colors.orange[100],
                    ),
                  )),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ActionChip(
                      avatar: Icon(
                        Icons.date_range_rounded, 
                        size: 18, 
                        color: hoursSpan == null ? Colors.white : theme.colorScheme.primary
                      ),
                      label: Text(
                        hoursSpan == null 
                            ? "${DateFormat('dd/MM').format(selectedDateRange!.start)} - ${DateFormat('dd/MM').format(selectedDateRange!.end)}"
                            : loc.customDates, 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: hoursSpan == null ? Colors.white : Colors.black87,
                        )
                      ),
                      backgroundColor: hoursSpan == null ? Colors.orange : Colors.grey[200],
                      onPressed: _pickDateRange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- GRAFICO ANIMATO FLUIDO ---
            Container(
              height: 300,
              padding: const EdgeInsets.only(top: 20, right: 30, left: 10, bottom: 10),
              child: LineChart(
                duration: const Duration(milliseconds: 600), 
                curve: Curves.fastOutSlowIn,
                LineChartData(
                  minY: 0, 
                  maxY: _calculateMaxY(drinks, user, axisStart, axisEnd), 
                  minX: _dateToX(axisStart), 
                  maxX: _dateToX(axisEnd), 
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey[200],
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: _getBottomTitlesInterval(totalAxisMinutes),
                        getTitlesWidget: (value, meta) {
                          if (value < meta.min || value > meta.max) return const SizedBox.shrink();
                          if (value == meta.max || (meta.max - value < (meta.appliedInterval * 0.6))) {
                            return const SizedBox.shrink();
                          }

                          final time = _xToDate(value);
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _formatBottomTitle(time, totalAxisMinutes), 
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          value.toStringAsFixed(1), 
                          style: const TextStyle(fontSize: 10, color: Colors.grey)
                        ),
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  
                  // --- LINEE EXTRA (Limite + Sobrietà) ---
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: user.legalLimit,
                        color: Colors.red.withOpacity(0.5),
                        strokeWidth: 2,
                        dashArray: [5, 5],
                        label: HorizontalLineLabel(
                          show: !user.isNewDriver,
                          alignment: Alignment.topRight,
                          labelResolver: (_) => "Limit",
                          style: const TextStyle(fontSize: 9, color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    verticalLines: () {
                      double currentBac = BacCalculator.calculateCurrentBAC(drinks, user);
                      if (currentBac > 0) {
                        DateTime exactSoberTime = DateTime.now().add(BacCalculator.timeUntilSober(currentBac));
                        if (exactSoberTime.isAfter(axisStart) && exactSoberTime.isBefore(axisEnd.add(const Duration(minutes: 5)))) {
                          return [
                            VerticalLine(
                              x: _dateToX(exactSoberTime),
                              color: Colors.green.withOpacity(0.8),
                              strokeWidth: 2,
                              dashArray: [4, 4], 
                              label: VerticalLineLabel(
                              show: true,
                              alignment: Alignment.bottomLeft, 
                              padding: const EdgeInsets.only(right: 6, bottom: 35), // <-- Padding aumentato a 35 per alzare il testo
                              style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold),
                              labelResolver: (_) => "0.0 g/l\n${DateFormat('HH:mm').format(exactSoberTime)}", 
                            ),
                            )
                          ];
                        }
                      }
                      return <VerticalLine>[]; 
                    }(),
                  ),
                  
                  lineBarsData: [
                    // 1. LINEA STORICA
                    LineChartBarData(
                      spots: _generateHistoricalSpots(drinks, user, axisStart, axisEnd),
                      isCurved: true,
                      preventCurveOverShooting: true, 
                      color: Colors.orange,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: Colors.orange.withOpacity(0.1)),
                    ),
                    // 2. LINEA PROIEZIONE FUTURA
                    LineChartBarData(
                      spots: _generateFutureSpots(drinks, user, axisStart, axisEnd),
                      isCurved: true,
                      preventCurveOverShooting: true, 
                      color: Colors.orange.withOpacity(0.6),
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dashArray: [8, 6], 
                      dotData: const FlDotData(show: false),
                    ),
                    // 3. I PUNTI DEI DRINK CON LE EMOJI (Linea invisibile, solo punti)
                    if (displayedDrinks.isNotEmpty)
                      LineChartBarData(
                        spots: displayedDrinks.map((d) {
                          // Calcoliamo dove stava il BAC in quel preciso istante per appoggiare l'icona sulla curva
                          double bacAtDrink = BacCalculator.calculateBACAtTime(drinks, user, d.timestamp).clamp(0.0, 10.0);
                          return FlSpot(_dateToX(d.timestamp), bacAtDrink);
                        }).toList(),
                        isCurved: false,
                        barWidth: 0, // Nascondiamo la linea, vogliamo solo le icone!
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            final drink = displayedDrinks[index];
                            return DrinkDotPainter(_getDrinkEmoji(drink.name));
                          },
                        ),
                      ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.black.withOpacity(0.8),
                      getTooltipItems: (spots) => spots.map((s) => LineTooltipItem(
                        "${s.y.toStringAsFixed(2)} g/l\n", 
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: DateFormat('HH:mm').format(_xToDate(s.x)), 
                            style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.normal)
                          )
                        ]
                      )).toList(),
                    ),
                  ),
                ),
              ),
            ),
            
            const Divider(height: 40),

            // --- CRONOLOGIA LISTA ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  loc.drinkHistory,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            displayedDrinks.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(loc.noDataAvailable, style: const TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: displayedDrinks.length,
                    itemBuilder: (context, index) {
                      // Inverto l'indice per mostrare dal più recente al più vecchio in lista
                      final drink = displayedDrinks[displayedDrinks.length - 1 - index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                            child: Icon(_getDrinkIcon(drink.name), color: theme.colorScheme.primary),
                          ),
                          title: Text(
                            _getTranslatedDrinkName(drink.name, loc), 
                            style: const TextStyle(fontWeight: FontWeight.bold)
                          ),
                          subtitle: Text(DateFormat('dd MMM, HH:mm').format(drink.timestamp)),
                          trailing: Text(
                            "${drink.abv.toStringAsFixed(2)}%",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
            
            const SizedBox(height: 120),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                loc.disclaimer,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  // --- HELPER METHODS MATEMATICI ---
  double _getBottomTitlesInterval(double totalMinutes) {
    if (totalMinutes > 43200) return 1440 * 7;  
    if (totalMinutes > 10080) return 1440 * 2;  
    if (totalMinutes > 2880) return 1440;       
    if (totalMinutes > 1440) return 360;        
    if (totalMinutes > 720) return 120;         
    return 60;                                  
  }

  String _formatBottomTitle(DateTime time, double totalMinutes) {
    if (totalMinutes > 43200) return DateFormat('dd MMM').format(time); 
    if (totalMinutes > 2880) return DateFormat('dd MMM').format(time);  
    if (totalMinutes >= 1440) return DateFormat('HH:mm\ndd/MM').format(time); 
    return DateFormat('HH:mm').format(time); 
  }

  double _calculateMaxY(drinks, user, DateTime start, DateTime end) {
    double maxBac = user.legalLimit; 
    final histSpots = _generateHistoricalSpots(drinks, user, start, end);
    final futSpots = _generateFutureSpots(drinks, user, start, end);
    
    for (var spot in [...histSpots, ...futSpots]) {
      if (spot.y > maxBac) maxBac = spot.y;
    }
    return (maxBac + 0.3).clamp(0.5, 5.0);
  }

  List<FlSpot> _generateHistoricalSpots(drinks, user, DateTime start, DateTime end) {
    if (drinks.isEmpty) return [FlSpot(_dateToX(start), 0)];
    
    List<FlSpot> spots = [];
    DateTime endOfHistory = (!end.isBefore(DateTime.now())) ? DateTime.now() : end;
    int totalHistMinutes = endOfHistory.difference(start).inMinutes;
    
    if (totalHistMinutes <= 0) return [FlSpot(_dateToX(start), 0)];

    double totalAxisMinutes = end.difference(start).inMinutes.toDouble();
    int stepMinutes = 15;
    if (totalAxisMinutes > 43200) stepMinutes = 1440; 
    else if (totalAxisMinutes > 10080) stepMinutes = 360; 
    else if (totalAxisMinutes > 2880) stepMinutes = 120; 
    else if (totalAxisMinutes > 1440) stepMinutes = 60; 

    for (int i = 0; i <= totalHistMinutes; i += stepMinutes) {
      DateTime t = start.add(Duration(minutes: i));
      double bac = BacCalculator.calculateBACAtTime(drinks, user, t).clamp(0.0, 10.0);
      spots.add(FlSpot(_dateToX(t), bac));
    }
    
    double finalBac = BacCalculator.calculateBACAtTime(drinks, user, endOfHistory).clamp(0.0, 10.0);
    spots.add(FlSpot(_dateToX(endOfHistory), finalBac));
    
    return spots;
  }

  List<FlSpot> _generateFutureSpots(drinks, user, DateTime start, DateTime end) {
    if (drinks.isEmpty) return [];
    if (end.isBefore(DateTime.now())) return [];

    List<FlSpot> spots = [];
    DateTime startFuture = DateTime.now();
    
    double currentBac = BacCalculator.calculateCurrentBAC(drinks, user);
    if (currentBac <= 0) return []; 

    int maxFutureMinutes = end.difference(startFuture).inMinutes;
    if (maxFutureMinutes <= 0) return [];

    double totalAxisMinutes = end.difference(start).inMinutes.toDouble();
    int stepMinutes = totalAxisMinutes > 1440 ? 60 : 15;

    for (int i = 0; i <= maxFutureMinutes; i += stepMinutes) {
      DateTime t = startFuture.add(Duration(minutes: i));
      double bac = BacCalculator.calculateBACAtTime(drinks, user, t).clamp(0.0, 10.0);
      
      spots.add(FlSpot(_dateToX(t), bac));
      
      if (bac <= 0) {
        spots.add(FlSpot(_dateToX(t), 0));
        break; 
      }
    }
    
    if (spots.length == 1) {
      spots.add(FlSpot(_dateToX(startFuture.add(const Duration(minutes: 5))), 0));
    }
    
    return spots;
  }
}
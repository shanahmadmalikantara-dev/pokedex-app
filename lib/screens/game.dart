import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/pokemon_data.dart';
import '../models/pokemon.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Pokemon? _pokemon1;
  Pokemon? _pokemon2;
  BattleResult? _result;

  static const Map<String, Map<String, double>> _typeChart = {
    'Fire':     {'Grass': 2, 'Ice': 2, 'Bug': 2, 'Steel': 2, 'Water': 0.5, 'Rock': 0.5, 'Fire': 0.5, 'Dragon': 0.5},
    'Water':    {'Fire': 2, 'Ground': 2, 'Rock': 2, 'Grass': 0.5, 'Water': 0.5, 'Dragon': 0.5},
    'Grass':    {'Water': 2, 'Ground': 2, 'Rock': 2, 'Fire': 0.5, 'Grass': 0.5, 'Poison': 0.5, 'Flying': 0.5, 'Bug': 0.5, 'Dragon': 0.5, 'Steel': 0.5},
    'Electric': {'Water': 2, 'Flying': 2, 'Grass': 0.5, 'Electric': 0.5, 'Dragon': 0.5, 'Ground': 0},
    'Ghost':    {'Ghost': 2, 'Psychic': 2, 'Normal': 0, 'Fighting': 0, 'Dark': 0.5},
    'Dragon':   {'Dragon': 2, 'Steel': 0.5, 'Fairy': 0},
    'Normal':   {'Rock': 0.5, 'Ghost': 0, 'Steel': 0.5},
    'Fighting': {'Normal': 2, 'Ice': 2, 'Rock': 2, 'Dark': 2, 'Steel': 2, 'Ghost': 0, 'Psychic': 0.5, 'Flying': 0.5, 'Poison': 0.5, 'Bug': 0.5, 'Fairy': 0.5},
    'Psychic':  {'Fighting': 2, 'Poison': 2, 'Psychic': 0.5, 'Steel': 0.5, 'Dark': 0},
    'Steel':    {'Ice': 2, 'Rock': 2, 'Fairy': 2, 'Steel': 0.5, 'Fire': 0.5, 'Water': 0.5, 'Electric': 0.5},
    'Dark':     {'Ghost': 2, 'Psychic': 2, 'Fighting': 0.5, 'Dark': 0.5, 'Fairy': 0.5},
    'Poison':   {'Grass': 2, 'Fairy': 2, 'Poison': 0.5, 'Ground': 0.5, 'Rock': 0.5, 'Ghost': 0.5, 'Steel': 0},
    'Rock':     {'Fire': 2, 'Ice': 2, 'Flying': 2, 'Bug': 2, 'Fighting': 0.5, 'Ground': 0.5, 'Steel': 0.5},
    'Ground':   {'Fire': 2, 'Electric': 2, 'Poison': 2, 'Rock': 2, 'Steel': 2, 'Grass': 0.5, 'Bug': 0.5, 'Flying': 0},
    'Flying':   {'Grass': 2, 'Fighting': 2, 'Bug': 2, 'Electric': 0.5, 'Rock': 0.5, 'Steel': 0.5},
    'Bug':      {'Grass': 2, 'Psychic': 2, 'Dark': 2, 'Fire': 0.5, 'Fighting': 0.5, 'Flying': 0.5, 'Ghost': 0.5, 'Steel': 0.5, 'Fairy': 0.5},
    'Ice':      {'Grass': 2, 'Ground': 2, 'Flying': 2, 'Dragon': 2, 'Steel': 0.5, 'Water': 0.5, 'Ice': 0.5, 'Fire': 0.5},
    'Fairy':    {'Fighting': 2, 'Dragon': 2, 'Dark': 2, 'Fire': 0.5, 'Poison': 0.5, 'Steel': 0.5},
  };

  double _getTypeEffectiveness(List<String> atkTypes, List<String> defTypes) {
    double total = 1.0;
    for (final a in atkTypes) {
      for (final d in defTypes) {
        total *= _typeChart[a]?[d] ?? 1.0;
      }
    }
    return total;
  }

  BattleResult _simulate(Pokemon p1, Pokemon p2) {
    final eff1 = _getTypeEffectiveness(p1.types, p2.types);
    final eff2 = _getTypeEffectiveness(p2.types, p1.types);

    final dmg1 = ((p1.stats['Atk']! / p2.stats['Def']!) * 50 * eff1 +
                  (p1.stats['Sp.Atk']! / p2.stats['Sp.Def']!) * 50 * eff1) / 2;
    final dmg2 = ((p2.stats['Atk']! / p1.stats['Def']!) * 50 * eff2 +
                  (p2.stats['Sp.Atk']! / p1.stats['Sp.Def']!) * 50 * eff2) / 2;

    final ko2 = p2.stats['HP']! / dmg1;
    final ko1 = p1.stats['HP']! / dmg2;

    double score1 = (1 / ko2) * 100;
    double score2 = (1 / ko1) * 100;

    if (p1.stats['Speed']! > p2.stats['Speed']!) score1 *= 1.15;
    if (p2.stats['Speed']! > p1.stats['Speed']!) score2 *= 1.15;

    final isDraw = (score1 - score2).abs() < 2;

    return BattleResult(
      winner: isDraw ? null : (score1 > score2 ? p1 : p2),
      isDraw: isDraw,
      effectiveness1: eff1,
      effectiveness2: eff2,
      dmgPerTurn1: dmg1,
      dmgPerTurn2: dmg2,
      turnsToKO1: ko1,
      turnsToKO2: ko2,
    );
  }

  void _runBattle() {
    if (_pokemon1 == null || _pokemon2 == null) return;
    setState(() {
      _result = _simulate(_pokemon1!, _pokemon2!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // VS selector row
                    Row(
                      children: [
                        Expanded(child: _buildSelector(_pokemon1, 1, (p) {
                          setState(() { _pokemon1 = p; _result = null; });
                        })),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('VS',
                              style: GoogleFonts.pressStart2p(
                                  fontSize: 14, color: const Color(0xFFCC0000))),
                        ),
                        Expanded(child: _buildSelector(_pokemon2, 2, (p) {
                          setState(() { _pokemon2 = p; _result = null; });
                        })),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Battle button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_pokemon1 != null && _pokemon2 != null)
                            ? _runBattle
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCC0000),
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('BATTLE!',
                            style: GoogleFonts.pressStart2p(
                                fontSize: 12, color: Colors.white)),
                      ),
                    ),

                    if (_result != null) ...[
                      const SizedBox(height: 20),
                      _buildResult(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF1A1D2E), size: 20),
          ),
          const SizedBox(width: 12),
          Text('BATTLE SIM',
              style: GoogleFonts.pressStart2p(
                  fontSize: 12, color: const Color(0xFF1A1D2E))),
        ],
      ),
    );
  }

  Widget _buildSelector(Pokemon? selected, int slot, Function(Pokemon) onSelect) {
    final isWinner = _result?.winner == selected && selected != null;
    final isLoser = _result != null && _result!.winner != null &&
        _result!.winner != selected && selected != null;

    return GestureDetector(
      onTap: () => _showPokemonPicker(onSelect),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isWinner
                ? Colors.amber
                : isLoser
                    ? Colors.red.shade300
                    : Colors.grey.shade300,
            width: isWinner ? 2.5 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: selected == null
              ? _buildEmptySlot(slot)
              : _buildFilledSlot(selected, isWinner, isLoser),
        ),
      ),
    );
  }

  Widget _buildEmptySlot(int slot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_circle_outline,
            color: Colors.grey.shade400, size: 30),
        const SizedBox(height: 8),
        Text('PILIH\nPOKÉMON $slot',
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(
                fontSize: 6.5,
                color: Colors.grey.shade400,
                height: 1.8)),
      ],
    );
  }

  Widget _buildFilledSlot(Pokemon p, bool isWinner, bool isLoser) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(p.imagePath, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey.shade100,
            child: Center(child: Text(p.emoji,
                style: const TextStyle(fontSize: 48))),
          ),
        ),
        // gradient bawah
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
            ),
          ),
        ),
        // nama & type
        Positioned(
          bottom: 8, left: 8, right: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.name.toUpperCase(),
                  style: GoogleFonts.pressStart2p(
                      fontSize: 7.5, color: Colors.white)),
              const SizedBox(height: 4),
              Row(
                children: p.types.map((t) => Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _typeColor(t),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(t.toUpperCase(),
                      style: GoogleFonts.pressStart2p(
                          fontSize: 5, color: Colors.white)),
                )).toList(),
              ),
            ],
          ),
        ),
        // badge menang/kalah
        if (isWinner)
          const Positioned(top: 8, right: 8,
              child: Text('👑', style: TextStyle(fontSize: 20))),
        if (isLoser)
          const Positioned(top: 8, right: 8,
              child: Text('💀', style: TextStyle(fontSize: 20))),
      ],
    );
  }

  Widget _buildResult() {
    final r = _result!;
    return Column(
      children: [
        // Banner pemenang
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: r.isDraw ? Colors.grey.shade200 : Colors.amber.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: r.isDraw ? Colors.grey.shade400 : Colors.amber,
              width: 1.5,
            ),
          ),
          child: Text(
            r.isDraw
                ? '🤝  DRAW!'
                : '🏆  ${r.winner!.name.toUpperCase()} MENANG!',
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(
              fontSize: 10,
              color: r.isDraw
                  ? Colors.grey.shade700
                  : Colors.amber.shade800,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Stat comparison
        _buildCard(
          title: 'STAT',
          child: _buildStatSection(),
        ),

        const SizedBox(height: 12),

        // Type matchup
        _buildCard(
          title: 'TYPE MATCHUP',
          child: Row(
            children: [
              Expanded(child: _typeEffBadge(
                _pokemon1!.name, r.effectiveness1)),
              const SizedBox(width: 10),
              Expanded(child: _typeEffBadge(
                _pokemon2!.name, r.effectiveness2)),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Breakdown
        _buildCard(
          title: 'DETAIL',
          child: Column(
            children: [
              _breakdownRow('${_pokemon1!.name} DMG/turn',
                  r.dmgPerTurn1.toStringAsFixed(1)),
              _breakdownRow('${_pokemon2!.name} DMG/turn',
                  r.dmgPerTurn2.toStringAsFixed(1)),
              _breakdownRow('KO ${_pokemon2!.name}',
                  '~${r.turnsToKO2.ceil()} turn'),
              _breakdownRow('KO ${_pokemon1!.name}',
                  '~${r.turnsToKO1.ceil()} turn'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.pressStart2p(
                  fontSize: 7,
                  color: Colors.grey.shade500,
                  letterSpacing: 1)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildStatSection() {
    final stats = ['HP', 'Atk', 'Def', 'Sp.Atk', 'Sp.Def', 'Speed'];
    return Column(
      children: stats.map((stat) {
        final v1 = _pokemon1!.stats[stat]!.toDouble();
        final v2 = _pokemon2!.stats[stat]!.toDouble();
        final max = v1 > v2 ? v1 : v2;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              // P1
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${v1.toInt()}',
                        style: GoogleFonts.pressStart2p(
                            fontSize: 6,
                            color: v1 >= v2
                                ? Colors.green.shade600
                                : Colors.grey.shade400)),
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        width: 50, height: 8,
                        child: LinearProgressIndicator(
                          value: v1 / (max == 0 ? 1 : max),
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation(
                              v1 >= v2
                                  ? Colors.green.shade400
                                  : Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Label
              SizedBox(
                width: 52,
                child: Text(stat,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(
                        fontSize: 5.5,
                        color: Colors.grey.shade600)),
              ),
              // P2
              Expanded(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        width: 50, height: 8,
                        child: LinearProgressIndicator(
                          value: v2 / (max == 0 ? 1 : max),
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation(
                              v2 >= v1
                                  ? Colors.orange.shade400
                                  : Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text('${v2.toInt()}',
                        style: GoogleFonts.pressStart2p(
                            fontSize: 6,
                            color: v2 >= v1
                                ? Colors.orange.shade600
                                : Colors.grey.shade400)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _typeEffBadge(String name, double eff) {
    String label;
    Color color;
    if (eff == 0) { label = 'IMMUNE'; color = Colors.grey; }
    else if (eff >= 4) { label = 'SUPER x4'; color = Colors.green.shade600; }
    else if (eff >= 2) { label = 'SUPER x2'; color = Colors.green.shade500; }
    else if (eff >= 1) { label = 'NORMAL'; color = Colors.blue.shade400; }
    else { label = 'RESIST'; color = Colors.red.shade400; }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(name.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                  fontSize: 5, color: Colors.grey.shade500, height: 1.5)),
          const SizedBox(height: 6),
          Text(label,
              style: GoogleFonts.pressStart2p(fontSize: 7, color: color)),
          Text('×${eff % 1 == 0 ? eff.toInt() : eff}',
              style: GoogleFonts.pressStart2p(
                  fontSize: 6, color: color.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _breakdownRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label,
                style: GoogleFonts.pressStart2p(
                    fontSize: 5.5,
                    color: Colors.grey.shade600,
                    height: 1.5)),
          ),
          const SizedBox(width: 8),
          Text(value,
              style: GoogleFonts.pressStart2p(
                  fontSize: 7, color: const Color(0xFF1A1D2E))),
        ],
      ),
    );
  }

  void _showPokemonPicker(Function(Pokemon) onSelect) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, scrollCtrl) => Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('PILIH POKÉMON',
                  style: GoogleFonts.pressStart2p(
                      fontSize: 10, color: const Color(0xFF1A1D2E))),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: pokemonList.length,
                itemBuilder: (_, i) {
                  final p = pokemonList[i];
                  return GestureDetector(
                    onTap: () { onSelect(p); Navigator.pop(context); },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(p.imagePath, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade100,
                                child: Center(child: Text(p.emoji,
                                    style: const TextStyle(fontSize: 36))),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.55),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(p.name.toUpperCase(),
                                      style: GoogleFonts.pressStart2p(
                                          fontSize: 8, color: Colors.white)),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: p.types.map((t) => Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _typeColor(t),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(t.toUpperCase(),
                                          style: GoogleFonts.pressStart2p(
                                              fontSize: 5,
                                              color: Colors.white)),
                                    )).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _typeColor(String type) {
    const colors = {
      'Fire': Color(0xFFFF6B35),
      'Water': Color(0xFF4FC3F7),
      'Grass': Color(0xFF66BB6A),
      'Electric': Color(0xFFFFD600),
      'Ghost': Color(0xFF7E57C2),
      'Dragon': Color(0xFF5C6BC0),
      'Normal': Color(0xFF8D8D8D),
      'Fighting': Color(0xFFEF5350),
      'Psychic': Color(0xFFEC407A),
      'Steel': Color(0xFF78909C),
      'Dark': Color(0xFF795548),
      'Poison': Color(0xFFAB47BC),
      'Rock': Color(0xFF8D6E63),
      'Ground': Color(0xFFD4A843),
      'Flying': Color(0xFF81D4FA),
      'Bug': Color(0xFF9CCC65),
      'Ice': Color(0xFF80DEEA),
      'Fairy': Color(0xFFF48FB1),
    };
    return colors[type] ?? const Color(0xFF8D8D8D);
  }
}

class BattleResult {
  final Pokemon? winner;
  final bool isDraw;
  final double effectiveness1, effectiveness2;
  final double dmgPerTurn1, dmgPerTurn2;
  final double turnsToKO1, turnsToKO2;

  BattleResult({
    required this.winner,
    required this.isDraw,
    required this.effectiveness1,
    required this.effectiveness2,
    required this.dmgPerTurn1,
    required this.dmgPerTurn2,
    required this.turnsToKO1,
    required this.turnsToKO2,
  });
}
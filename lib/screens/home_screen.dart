import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/pokemon_data.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_card.dart';
import '../screens/game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _search = '';
  String _filterType = 'All';

  final List<String> _types = [
    'All', 'Fire', 'Water', 'Grass', 'Electric',
    'Ghost', 'Dragon', 'Normal', 'Fighting',
    'Psychic', 'Steel', 'Dark', 'Poison',
  ];

  List<Pokemon> get _filtered => pokemonList.where((p) {
    final matchName = p.name.toLowerCase().contains(_search.toLowerCase());
    final matchType = _filterType == 'All' || p.types.contains(_filterType);
    return matchName && matchType;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      bottomNavigationBar: _buildPlayButton(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildTypeFilter(),
            Expanded(child: _buildList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 4),
              Text(
                '${_filtered.length} Pokémon tersedia',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFCC0000),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFCC0000).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.catching_pokemon,
                color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: (v) => setState(() => _search = v),
          style: GoogleFonts.nunito(
            color: const Color(0xFF1A1D2E),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: 'Cari Pokémon...',
            hintStyle: GoogleFonts.nunito(
              color: Colors.black26,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: const Icon(Icons.search_rounded,
                color: Colors.black26, size: 22),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeFilter() {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 12),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: _types.length,
          itemBuilder: (_, i) {
            final t = _types[i];
            final selected = _filterType == t;
            return GestureDetector(
              onTap: () => setState(() => _filterType = t),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF1A1D2E)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF1A1D2E).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          )
                        ],
                ),
                child: Center(
                  child: Text(
                    t,
                    style: GoogleFonts.nunito(
                      color: selected ? Colors.white : Colors.black45,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('😢', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              'Pokémon tidak ditemukan',
              style: GoogleFonts.nunito(
                color: Colors.black38,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
      itemCount: _filtered.length,
      itemBuilder: (ctx, i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 250 + (i * 50)),
            curve: Curves.easeOut,
            builder: (_, val, child) => Opacity(
              opacity: val,
              child: Transform.translate(
                offset: Offset(0, 16 * (1 - val)),
                child: child,
              ),
            ),
            child: PokemonCard(pokemon: _filtered[i]),
          ),
        );
      },
    );
  }

  Widget _buildPlayButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const GameScreen(),
                transitionDuration: const Duration(milliseconds: 600),
                transitionsBuilder: (_, anim, __, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1), // slide dari bawah
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: anim,
                      curve: Curves.easeOutCubic,
                    )),
                    child: FadeTransition(opacity: anim, child: child),
                  );
                },
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFCC0000),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFCC0000).withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.catching_pokemon,
                    color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(
                  'PLAY',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
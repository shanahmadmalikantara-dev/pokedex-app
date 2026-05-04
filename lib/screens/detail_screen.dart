import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/pokemon.dart';
import '../utils/type_colors.dart';
import '../widgets/stat_bar.dart';

class DetailScreen extends StatelessWidget {
  final Pokemon pokemon;
  const DetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final baseColor = TypeColors.getColor(pokemon.types[0]);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, baseColor),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildInfoRow(baseColor),
                _buildSection(
                  '📖 Deskripsi',
                  _buildDescription(),
                ),
                _buildSection(
                  '📊 Base Stats',
                  _buildStats(baseColor),
                ),
                _buildSection(
                  '⚠️ Kelemahan',
                  _buildWeaknesses(),
                ),
                _buildSection(
                  '🤝 Partner Terbaik',
                  _buildPartners(baseColor),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Color baseColor) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Color(0xFF1A1D2E), size: 18),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: Stack(
            children: [
              // Color accent top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: baseColor.withOpacity(0.1),
                  ),
                ),
              ),
              // Big pokeball bg
              Positioned(
                right: -30,
                top: 20,
                child: Icon(
                  Icons.catching_pokemon,
                  size: 200,
                  color: baseColor.withOpacity(0.08),
                ),
              ),
              // Pokemon name in bg
              Positioned(
                top: 90,
                left: 20,
                right: 20,
                child: Text(
                  pokemon.name.toUpperCase(),
                  style: GoogleFonts.nunito(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: baseColor.withOpacity(0.07),
                    letterSpacing: -2,
                  ),
                ),
              ),
              // Pokemon image
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: 'pokemon_${pokemon.id}',
                  child: Image.asset(
                    pokemon.imagePath,
                    height: 190,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Text(
                      pokemon.emoji,
                      style: const TextStyle(fontSize: 110),
                    ),
                  ),
                ),
              ),
              // ID badge
              Positioned(
                top: 85,
                left: 20,
                child: Text(
                  '#${pokemon.id.toString().padLeft(3, '0')}',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: baseColor.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(Color baseColor) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  pokemon.name,
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1A1D2E),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Text(pokemon.emoji, style: const TextStyle(fontSize: 26)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ...pokemon.types.map((t) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: TypeColors.getColor(t).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    t,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: TypeColors.getColor(t),
                    ),
                  ),
                ),
              )),
              const Spacer(),
              // Role chip
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1D2E).withOpacity(0.07),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  pokemon.role.split('/')[0].trim(),
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1D2E).withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Ability & Evolution
          Row(
            children: [
              _miniInfo('Ability', pokemon.ability, baseColor),
              if (pokemon.evolution != null) ...[
                const SizedBox(width: 10),
                _miniInfo('Evolusi', pokemon.evolution!, Colors.green),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniInfo(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
            style: GoogleFonts.nunito(
              fontSize: 10, color: color.withOpacity(0.7),
              fontWeight: FontWeight.w700,
            )),
          Text(value,
            style: GoogleFonts.nunito(
              fontSize: 13, color: const Color(0xFF1A1D2E),
              fontWeight: FontWeight.w800,
            )),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1D2E),
            )),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        pokemon.description,
        style: GoogleFonts.nunito(
          fontSize: 14,
          color: Colors.black54,
          height: 1.7,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStats(Color baseColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: pokemon.stats.entries
          .map((e) => StatBar(label: e.key, value: e.value, color: baseColor))
          .toList(),
      ),
    );
  }

  Widget _buildWeaknesses() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: pokemon.weaknesses.map((w) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: TypeColors.getColor(w).withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: TypeColors.getColor(w).withOpacity(0.3),
          ),
        ),
        child: Text(w,
          style: GoogleFonts.nunito(
            color: TypeColors.getColor(w),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          )),
      )).toList(),
    );
  }

  Widget _buildPartners(Color baseColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: pokemon.partners.asMap().entries.map((e) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: baseColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${e.key + 1}',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: baseColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Text(e.value,
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1D2E),
                )),
            ],
          ),
        )).toList(),
      ),
    );
  }
}
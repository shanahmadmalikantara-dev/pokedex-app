class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String imagePath;
  final Map<String, int> stats;
  final String ability;
  final List<String> weaknesses;
  final String description;
  final String role;
  final List<String> partners;
  final String? evolution;
  final String emoji;

  const Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.imagePath,
    required this.stats,
    required this.ability,
    required this.weaknesses,
    required this.description,
    required this.role,
    required this.partners,
    this.evolution,
    required this.emoji,
  });
}
enum RelaxationType { meditation, music, breathing, story, reading }

class RelaxationItem {
  final String id;
  final RelaxationType type;
  final String title;
  final String description;
  final String duration;
  final String illustrationEmoji; // placeholder sampai ada aset gambar

  const RelaxationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.duration,
    required this.illustrationEmoji,
  });
}

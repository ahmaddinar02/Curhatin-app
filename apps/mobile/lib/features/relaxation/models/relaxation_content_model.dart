class MeditationSession {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final List<String> steps;

  const MeditationSession({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.steps,
  });
}

class BreathingExercise {
  final String id;
  final String title;
  final String description;
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final int rounds;

  const BreathingExercise({
    required this.id,
    required this.title,
    required this.description,
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
    required this.rounds,
  });
}

class RelaxationStory {
  final String id;
  final String title;
  final String author;
  final String excerpt;
  final String content;
  final int readingMinutes;

  const RelaxationStory({
    required this.id,
    required this.title,
    required this.author,
    required this.excerpt,
    required this.content,
    required this.readingMinutes,
  });
}

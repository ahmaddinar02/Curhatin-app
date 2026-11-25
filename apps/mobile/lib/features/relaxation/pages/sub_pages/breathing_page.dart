import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/relaxation_theme.dart';
import '../../data/dummy_relaxation_data.dart';
import '../../models/relaxation_content_model.dart';

enum _BreathPhase { inhale, hold, exhale, idle }

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  _BreathPhase _phase = _BreathPhase.idle;
  int _countdown = 0;
  int _roundsLeft = 0;
  Timer? _timer;
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  BreathingExercise get _current =>
      DummyRelaxationData.breathingExercises[_selectedIndex];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.3).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _startSession() {
    _roundsLeft = _current.rounds;
    _runPhase(_BreathPhase.inhale, _current.inhaleSeconds);
  }

  void _stopSession() {
    _timer?.cancel();
    _animController.stop();
    _animController.reset();
    setState(() {
      _phase = _BreathPhase.idle;
      _countdown = 0;
      _roundsLeft = 0;
    });
  }

  void _runPhase(_BreathPhase phase, int seconds) {
    if (!mounted) return;
    setState(() {
      _phase = phase;
      _countdown = seconds;
    });

    if (phase == _BreathPhase.inhale) {
      _animController.duration = Duration(seconds: seconds);
      _animController.forward(from: 0);
    } else if (phase == _BreathPhase.exhale) {
      _animController.duration = Duration(seconds: seconds);
      _animController.reverse(from: 1);
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _countdown--);
      if (_countdown <= 0) {
        t.cancel();
        _nextPhase(phase);
      }
    });
  }

  void _nextPhase(_BreathPhase current) {
    switch (current) {
      case _BreathPhase.inhale:
        if (_current.holdSeconds > 0) {
          _runPhase(_BreathPhase.hold, _current.holdSeconds);
        } else {
          _runPhase(_BreathPhase.exhale, _current.exhaleSeconds);
        }
        break;
      case _BreathPhase.hold:
        _runPhase(_BreathPhase.exhale, _current.exhaleSeconds);
        break;
      case _BreathPhase.exhale:
        setState(() => _roundsLeft--);
        if (_roundsLeft > 0) {
          _runPhase(_BreathPhase.inhale, _current.inhaleSeconds);
        } else {
          _stopSession();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Latihan selesai! Kamu luar biasa 🌬️'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        break;
      case _BreathPhase.idle:
        break;
    }
  }

  String get _phaseLabel {
    switch (_phase) {
      case _BreathPhase.inhale:
        return 'Tarik Napas';
      case _BreathPhase.hold:
        return 'Tahan';
      case _BreathPhase.exhale:
        return 'Hembuskan';
      case _BreathPhase.idle:
        return 'Siap?';
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercises = DummyRelaxationData.breathingExercises;

    return Scaffold(
      backgroundColor: RelaxationColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tabs teknik
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: exercises.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final sel = i == _selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      _stopSession();
                      setState(() => _selectedIndex = i);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: sel
                            ? RelaxationColors.primary
                            : RelaxationColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sel
                              ? RelaxationColors.primary
                              : RelaxationColors.divider,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          exercises[i].title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color:
                                sel ? Colors.white : RelaxationColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Deskripsi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(_current.description,
                  style: RelaxationTextStyles.cardDescription
                      .copyWith(fontSize: 13),
                  textAlign: TextAlign.center),
            ),

            const SizedBox(height: 16),

            // Lingkaran animasi napas
            ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      RelaxationColors.primaryLight.withValues(alpha: 0.6),
                      RelaxationColors.primary.withValues(alpha: 0.2),
                    ],
                  ),
                  border:
                      Border.all(color: RelaxationColors.primary, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _phaseLabel,
                      style: const TextStyle(
                        color: RelaxationColors.primaryDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    if (_phase != _BreathPhase.idle) ...[
                      const SizedBox(height: 6),
                      Text(
                        '$_countdown',
                        style: const TextStyle(
                          color: RelaxationColors.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                    ] else
                      const Text('🌬️', style: TextStyle(fontSize: 36)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Ronde tersisa
            if (_phase != _BreathPhase.idle)
              Text(
                'Sisa: $_roundsLeft / ${_current.rounds} putaran',
                style: RelaxationTextStyles.cardDescription,
              ),

            // Pola pernapasan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRhythmBox('Hirup', '${_current.inhaleSeconds}s',
                      RelaxationColors.breathing),
                  if (_current.holdSeconds > 0)
                    _buildRhythmBox('Tahan', '${_current.holdSeconds}s',
                        RelaxationColors.meditation),
                  _buildRhythmBox('Hembuskan', '${_current.exhaleSeconds}s',
                      RelaxationColors.music),
                ],
              ),
            ),

            // Tombol mulai/stop
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _phase == _BreathPhase.idle
                      ? _startSession
                      : _stopSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _phase == _BreathPhase.idle
                        ? RelaxationColors.primary
                        : const Color(0xFFEF4444),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  icon: Icon(
                    _phase == _BreathPhase.idle
                        ? Icons.play_arrow_rounded
                        : Icons.stop_rounded,
                    size: 22,
                  ),
                  label: Text(
                    _phase == _BreathPhase.idle
                        ? 'Mulai Latihan (${_current.rounds}x putaran)'
                        : 'Hentikan',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildRhythmBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: RelaxationColors.primaryDark)),
          const SizedBox(height: 2),
          Text(label, style: RelaxationTextStyles.caption),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: RelaxationColors.surfaceWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: RelaxationColors.primary, size: 18),
          ),
        ),
      ),
      title: const Text('PERNAPASAN', style: RelaxationTextStyles.appBarTitle),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: RelaxationColors.divider),
      ),
    );
  }
}

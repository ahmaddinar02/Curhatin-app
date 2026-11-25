import 'package:flutter/material.dart';
import 'journal_write_screens.dart';

// ── MODEL DATA JURNAL ────────────────────────────────────────────
class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  bool isDeleted;
  DateTime? deletedAt;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.isDeleted = false,
    this.deletedAt,
  });

  int get daysUntilPermanentDelete {
    if (deletedAt == null) return 30;
    return 30 - DateTime.now().difference(deletedAt!).inDays;
  }
}

// ── HALAMAN UTAMA JURNAL ─────────────────────────────────────────
class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  // Data dummy jurnal
  final List<JournalEntry> _journals = [
    JournalEntry(
      id: '1',
      title: 'Evaluasi Sidang Proposal',
      content: 'Hari ini akhirnya selesai revisi bab 3 setelah berkali-kali tertunda.',
      createdAt: DateTime.now(),
    ),
    JournalEntry(
      id: '2',
      title: 'Overthinking Praktikum Besok',
      content: 'Merasa cemas dan tidak siap untuk praktikum besok pagi.',
      createdAt: DateTime.now(),
    ),
    JournalEntry(
      id: '3',
      title: 'Beban Tugas Kelompok Menumpuk',
      content: 'Tugas kelompok semakin menumpuk dan terasa sangat berat.',
      createdAt: DateTime.now(),
    ),
    JournalEntry(
      id: '4',
      title: 'Gazebo Rektorat Sore Hari',
      content: 'Sore ini menikmati suasana tenang di gazebo rektorat.',
      createdAt: DateTime.now(),
    ),
    JournalEntry(
      id: '5',
      title: 'Belajar Mengatur Batas Diri',
      content: 'Hari ini belajar untuk bilang "tidak" pada hal yang membebani.',
      createdAt: DateTime.now(),
    ),
    JournalEntry(
      id: '6',
      title: 'Merasa Tertinggal dari Teman Lain',
      content: 'Perasaan tertinggal dari teman-teman yang sudah lebih maju.',
      createdAt: DateTime.now(),
    ),
  ];

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: isError ? const Color(0xFFE53935) : const Color(0xFF2B70E4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  List<JournalEntry> get _activeJournals =>
      _journals.where((j) => !j.isDeleted).toList();

  List<JournalEntry> get _trashJournals =>
      _journals.where((j) => j.isDeleted).toList();

  void _deleteJournal(JournalEntry entry) {
    setState(() {
      entry.isDeleted = true;
      entry.deletedAt = DateTime.now();
    });
    _showSnackbar('Jurnal dipindahkan ke kotak sampah');
  }

  void _restoreJournal(JournalEntry entry) {
    setState(() {
      entry.isDeleted = false;
      entry.deletedAt = null;
    });
    _showSnackbar('Jurnal berhasil dipulihkan');
  }

  void _permanentDelete(JournalEntry entry) {
    setState(() {
      _journals.remove(entry);
    });
    _showSnackbar('Jurnal dihapus permanen', isError: true);
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    if (dt.day == now.day && dt.month == now.month && dt.year == now.year) {
      return 'Hari ini • ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9EAFD),
      body: Stack(
        children: [
          // ── BACKGROUND ─────────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/image/bg_bubble.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ── KONTEN ─────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // ── HEADER ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.80),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFF6B8AB8),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Jurnal Harian',
                          style: TextStyle(
                            color: Color(0xFF061854),
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      // Maskot Curhatin (diperbesar)
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: Image.asset(
                          'assets/image/maskot.png',
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Color(0xFF2B6FDE),
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // ── DAFTAR JURNAL (GRID) ───────────────────────
                Expanded(
                  child: _activeJournals.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.book_outlined, size: 60, color: Colors.grey.shade300),
                              const SizedBox(height: 12),
                              const Text(
                                'Belum ada jurnal.\nMulai tulis ceritamu!',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF808EAA), fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              // Grid jurnal (Masonry-style dengan 2 kolom)
                              _buildJournalGrid(),

                              const SizedBox(height: 14),

                              // ── KOTAK SAMPAH ─────────────────────
                              if (_trashJournals.isNotEmpty) _buildTrashBox(),

                              const SizedBox(height: 80), // Ruang untuk tombol di bawah
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),

          // ── TOMBOL TULIS JURNAL (+) (FLOAT DI KANAN BAWAH) ───
          Positioned(
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 20,
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF2B6FDE),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2B6FDE).withOpacity(0.40),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const JournalWritePage()),
                    );
                    if (result is JournalEntry) {
                      setState(() => _journals.insert(0, result));
                      _showSnackbar('Jurnal berhasil disimpan!');
                    }
                  },
                  borderRadius: BorderRadius.circular(29),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── GRID JURNAL ─────────────────────────────────────────────────
  Widget _buildJournalGrid() {
    final items = _activeJournals;
    final List<Widget> leftColumn = [];
    final List<Widget> rightColumn = [];

    for (int i = 0; i < items.length; i++) {
      final card = _buildJournalCard(items[i]);
      if (i.isEven) {
        leftColumn.add(card);
      } else {
        rightColumn.add(card);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(children: leftColumn),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(children: rightColumn),
        ),
      ],
    );
  }

  // ── KARTU JURNAL SATUAN ─────────────────────────────────────────
  Widget _buildJournalCard(JournalEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90D9).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row — label + menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Label
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF3FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.book_outlined, color: Color(0xFF2B6FDE), size: 12),
                    SizedBox(width: 4),
                    Text(
                      'Jurnal',
                      style: TextStyle(
                        color: Color(0xFF2B6FDE),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Menu titik tiga
              GestureDetector(
                onTap: () => _showCardMenu(entry),
                child: const Icon(Icons.more_vert, color: Color(0xFF808EAA), size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Judul
          Text(
            entry.title,
            style: const TextStyle(
              color: Color(0xFF061854),
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),

          // Waktu
          Text(
            _formatTime(entry.createdAt),
            style: const TextStyle(
              color: Color(0xFF808EAA),
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),

          // Buka Refleksi
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => JournalWritePage(existingEntry: entry),
                ),
              );
              if (result is JournalEntry) {
                setState(() {
                  final index = _journals.indexWhere((j) => j.id == result.id);
                  if (index != -1) _journals[index] = result;
                });
              }
            },
            child: const Text(
              'Buka Refleksi →',
              style: TextStyle(
                color: Color(0xFF2B6FDE),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCardMenu(JournalEntry entry) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: Color(0xFF2B6FDE)),
              title: const Text('Edit Jurnal'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JournalWritePage(existingEntry: entry),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Color(0xFFE53935)),
              title: const Text('Hapus Jurnal', style: TextStyle(color: Color(0xFFE53935))),
              onTap: () {
                Navigator.pop(ctx);
                _deleteJournal(entry);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── KOTAK SAMPAH ────────────────────────────────────────────────
  Widget _buildTrashBox() {
    return GestureDetector(
      onTap: () => _showTrashSheet(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A90D9).withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_outline, color: Color(0xFF808EAA), size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kotak Sampah Jurnal',
                    style: TextStyle(
                      color: Color(0xFF061854),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Catatan otomatis terhapus',
                    style: TextStyle(
                      color: Color(0xFF808EAA),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_trashJournals.length} catatan',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Color(0xFF808EAA), size: 20),
          ],
        ),
      ),
    );
  }

  void _showTrashSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD6DFEC),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kotak Sampah',
              style: TextStyle(
                color: Color(0xFF061854),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Jurnal akan otomatis terhapus setelah 30 hari',
              style: TextStyle(color: Color(0xFF808EAA), fontSize: 12),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _trashJournals.isEmpty
                  ? const Center(
                      child: Text(
                        'Kotak sampah kosong',
                        style: TextStyle(color: Color(0xFF808EAA)),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _trashJournals.length,
                      itemBuilder: (_, i) => _buildTrashCard(_trashJournals[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrashCard(JournalEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge sisa hari
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFFCC02), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer_outlined, color: Color(0xFFE65100), size: 13),
                    const SizedBox(width: 4),
                    Text(
                      'Tersisa ${entry.daysUntilPermanentDelete} hari',
                      style: const TextStyle(
                        color: Color(0xFFE65100),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _permanentDelete(entry);
                },
                child: const Icon(Icons.delete_forever_outlined, color: Color(0xFFE53935), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            entry.deletedAt != null
                ? 'Dihapus ${DateTime.now().difference(entry.deletedAt!).inDays} hari lalu'
                : '',
            style: const TextStyle(color: Color(0xFF808EAA), fontSize: 11),
          ),
          const SizedBox(height: 8),
          Text(
            entry.title,
            style: const TextStyle(
              color: Color(0xFF061854),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          // Tombol Pulihkan
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                _restoreJournal(entry);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.restore, color: Color(0xFF5C6BC0), size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Pulihkan Catatan',
                      style: TextStyle(
                        color: Color(0xFF5C6BC0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

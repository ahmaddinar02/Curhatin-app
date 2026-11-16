import 'package:flutter/material.dart';
import 'journal_page_screens.dart';

class JournalWritePage extends StatefulWidget {
  final JournalEntry? existingEntry;

  const JournalWritePage({super.key, this.existingEntry});

  @override
  State<JournalWritePage> createState() => _JournalWritePageState();
}

class _JournalWritePageState extends State<JournalWritePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingEntry?.title ?? '');
    _contentController = TextEditingController(text: widget.existingEntry?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

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

  void _saveJournal() {
    if (_titleController.text.trim().isEmpty) {
      _showSnackbar('Judul jurnal harus diisi', isError: true);
      return;
    }
    if (_contentController.text.trim().isEmpty) {
      _showSnackbar('Isi jurnal tidak boleh kosong', isError: true);
      return;
    }

    final entry = JournalEntry(
      id: widget.existingEntry?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      createdAt: widget.existingEntry?.createdAt ?? DateTime.now(),
    );

    Navigator.pop(context, entry);
  }

  String _formatDate(DateTime dt) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month - 1]} ${dt.year} • '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} WIB';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isEditing = widget.existingEntry != null;

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
                // ── HEADER BIRU ────────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B6FDE),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2B6FDE).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.20),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isEditing ? 'Edit Catatan Jurnal' : 'Tulis Catatan Jurnal',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── FORM AREA (KOTAK PUTIH DIPERPANJANG KE BAWAH) ──
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4A90D9).withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tanggal
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, color: Color(0xFF808EAA), size: 14),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                _formatDate(widget.existingEntry?.createdAt ?? now),
                                style: const TextStyle(
                                  color: Color(0xFF808EAA),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // Status auto-save
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF34A853),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Tersimpan Otomatis',
                                  style: TextStyle(
                                    color: Color(0xFF34A853),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Input Judul
                        TextField(
                          controller: _titleController,
                          style: const TextStyle(
                            color: Color(0xFF061854),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Judul Jurnal...',
                            hintStyle: TextStyle(
                              color: Color(0xFFB0BEC5),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),

                        const Divider(color: Color(0xFFE5EAF2), height: 24),

                        // Input Konten (Expanded mengisi sisa ruang kotak putih secara leluasa)
                        Expanded(
                          child: TextField(
                            controller: _contentController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(
                              color: Color(0xFF3A4A5E),
                              fontSize: 14,
                              height: 1.7,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Mulai tulis ceritamu di sini...\n\nBagikan apa yang kamu rasakan hari ini. '
                                  'Tidak ada yang menilai, ini ruang amanmu.',
                              hintStyle: TextStyle(
                                color: Color(0xFFB0BEC5),
                                fontSize: 14,
                                height: 1.7,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16), // Jarak yang cukup antara kotak putih dan tombol simpan

                // ── TOMBOL SIMPAN CATATAN JURNAL ───────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _saveJournal,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B6FDE),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 20, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Simpan Catatan Jurnal',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

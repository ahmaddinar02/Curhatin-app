import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/forum_theme.dart';
import '../models/discussion_model.dart';

class CreateDiscussionPage extends StatefulWidget {
  const CreateDiscussionPage({super.key});

  @override
  State<CreateDiscussionPage> createState() => _CreateDiscussionPageState();
}

class _CreateDiscussionPageState extends State<CreateDiscussionPage> {
  final TextEditingController _contentController = TextEditingController();
  bool _isPublishing = false;

  bool get _isValid => _contentController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    if (!_isValid) return;
    setState(() => _isPublishing = true);

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final newDiscussion = DiscussionModel(
      id: 'new_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'current_user',
      userName: 'Aku',
      userAvatar: 'https://i.pravatar.cc/150?img=1',
      content: _contentController.text.trim(),
      category: 'Curhat',
      createdAt: DateTime.now(),
      likeCount: 0,
      commentCount: 0,
      isLiked: false,
    );

    if (!mounted) return;
    setState(() => _isPublishing = false);
    Navigator.of(context).pop(newDiscussion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info row
                _buildUserRow(),

                const SizedBox(height: 20),

                // Content input
                _buildContentInput(),

                const SizedBox(height: 24),

                // Publish button
                _buildPublishButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surfaceWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
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
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 18,
            ),
          ),
        ),
      ),
      
      title: const Text(
        'Diskusi Baru',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(0xFF2B7AFC),
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: AppColors.divider),
      ),
    );
  }

  Widget _buildUserRow() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primarySurface,
            border: Border.all(
              color: AppColors.primaryLight.withValues(alpha: 0.4),
              width: 2,
            ),
          ),
          child: const Center(
            child: Text(
              'A',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aku',
              style: AppTextStyles.heading3,
            ),
            Text(
              'Memposting secara publik',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _contentController,
          maxLines: null,
          minLines: 6,
          keyboardType: TextInputType.multiline,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText:
                'Bagikan cerita, pengalaman, atau perasaanmu di sini...\n\nIngat, kamu tidak sendirian. Komunitas Curhatin siap mendengarkan 💙',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            filled: true,
            fillColor: AppColors.surfaceWhite,
            contentPadding: const EdgeInsets.all(14),
          ),
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${_contentController.text.trim().length} karakter',
            style: AppTextStyles.caption,
          ),
        ),
      ],
    );
  }

  Widget _buildPublishButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _isValid ? 1.0 : 0.5,
        child: ElevatedButton(
          onPressed: _isValid && !_isPublishing ? _publish : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: _isPublishing
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  'Publikasikan Diskusi',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
        ),
      ),
    );
  }
}

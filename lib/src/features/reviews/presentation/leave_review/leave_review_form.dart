import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/primary_button.dart';
import '../../../../utils/async_value_ui.dart';
import '../movie_review/movie_rating_bar.dart';
import 'leave_review_controller.dart';

class LeaveReviewForm extends ConsumerStatefulWidget {
  const LeaveReviewForm({required this.movietId, super.key});

  final String movietId;

  @override
  ConsumerState<LeaveReviewForm> createState() => _LeaveReviewFormState();
}

class _LeaveReviewFormState extends ConsumerState<LeaveReviewForm> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(leaveReviewControllerProvider);
    ref.listen<AsyncValue>(
      leaveReviewControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    ref.listen<AsyncValue>(leaveReviewControllerProvider, (_, state) {
      if (state is AsyncData) {
        _titleController.clear();
        _bodyController.clear();
        _rating = 0;
      }
    });
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: 'Your title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _bodyController,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Your review',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: MovieRatingBar(
              initialRating: _rating,
              onRatingUpdate: (rating) => setState(() => _rating = rating),
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'Submit',
            isLoading: state.isLoading,
            onPressed: state.isLoading ||
                    _rating == 0 ||
                    _titleController.text.trim().isEmpty ||
                    _bodyController.text.trim().isEmpty
                ? null
                : () => ref
                    .read(leaveReviewControllerProvider.notifier)
                    .submitReview(
                      title: _titleController.text,
                      body: _bodyController.text,
                      rating: _rating.toInt(),
                      movieId: widget.movietId,
                    ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

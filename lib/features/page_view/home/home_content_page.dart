import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/sizes.dart';
import '../../../shared/utils/end_of_month.dart';
import '../data_controller.dart';
import '../data_states.dart';
import 'home_controller.dart';
import 'widgets/pending_card.dart';
import 'widgets/transactions_summary.dart';
import 'widgets/resume_info_widget.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionList =
        (context.read<DataController>().state as SuccessDataState)
            .transactionList;
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => HomeController(transactionList),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ResumeInfoWidget(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Sizes.mediumSpace),
              child: Text(
                'Até o dia ${DateTime.now().endOfMonthStr()}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.smallSpace),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PendingCard.expense(),
                  ),
                  Expanded(
                    flex: 1,
                    child: PendingCard.income(),
                  ),
                ],
              ),
            ),
            const TransactionsSummary(),
          ],
        ),
      ),
    );
  }
}

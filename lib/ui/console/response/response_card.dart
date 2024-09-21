import 'package:fcm_app_tester/ui/console/console_cubit.dart';
import 'package:fcm_app_tester/ui/console/state/console_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResponseCard extends StatelessWidget {
  const ResponseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      title: Text(
        "Response",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      children: [_body(context, false)],
    );
  }

  Widget _body(BuildContext context, bool darkTheme) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<ConsoleCubit, ConsoleState>(
            builder: (context, state) {
              if (state is ConsoleLoadingState) {
                return const _ResponseLoadingView();
              } else if (state is ConsoleResultState) {
                return _ResponseResultView(state: state);
              }
              return const _ResponseIdealView();
            },
          )
        ],
      ),
    );
  }
}

class _ResponseResultView extends StatelessWidget {
  final ConsoleResultState state;

  const _ResponseResultView({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final code = state.code;
    if (code < 100) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(
              width: 96,
              height: 96,
              child: Image.asset(
                "assets/images/ic_error.png",
                width: 500,
                height: 500,
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              "Could not sent request",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 4),
            SelectableText(
              state.error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "Status\t\t",
              children: [
                TextSpan(
                  text: code.toString(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _statusColor(code),
                      ),
                ),
              ],
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            state.error,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      );
    }
  }

  Color _statusColor(int status) {
    if (status <= 299) {
      return Colors.green[300]!;
    } else if (status <= 399) {
      return Colors.orange[300]!;
    } else if (status <= 499) {
      return Colors.red[300]!;
    } else {
      return Colors.black;
    }
  }
}

class _ResponseIdealView extends StatelessWidget {
  const _ResponseIdealView();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Text(
        "Click Send to get a response",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _ResponseLoadingView extends StatelessWidget {
  const _ResponseLoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text("Sending a request"),
        ],
      ),
    );
  }
}

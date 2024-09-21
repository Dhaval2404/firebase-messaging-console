sealed class ConsoleState {}

class ConsoleInitialState extends ConsoleState {}

class ConsoleLoadingState extends ConsoleState {}

class ConsoleResultState extends ConsoleState {
  final String error;
  final int code;

  ConsoleResultState({
    required this.code,
    required this.error,
  });
}

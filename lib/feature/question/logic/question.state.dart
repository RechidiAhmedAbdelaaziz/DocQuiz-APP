part of 'questions.cubit.dart';

class QuestionState extends ErrorState {
  QuestionState({
    required List<QuestionResultModel?> questions,
    int currentIndex = 0,
    required int max,
    String? error,
    List<int>? correctIndexes,
    List<int>? wrongIndexes,
  })  : _max = max,
        _currentIndex = currentIndex,
        _questions = questions,
        _correctIndexes = correctIndexes ?? [],
        _wrongIndexes = wrongIndexes ?? [],
        super(error);

  final List<QuestionResultModel?> _questions;
  final int _currentIndex;
  final int _max;
  final List<int> _correctIndexes;
  final List<int> _wrongIndexes;

  List<QuestionResultModel?> get questions => _questions;

  bool exists(int index) => _questions[index] != null;
  bool isAnswered(int index) =>
      _questions[index]?.result.isAnswerd == true ||
      _correctIndexes.contains(index) ||
      _wrongIndexes.contains(index);

  bool isCorrect(int index) =>
      _questions[index]?.result.isCorrect == true ||
      _correctIndexes.contains(index);

  bool isCurrent(int index) => _currentIndex == index;

  int get max => _max;

  int page(int index) => (index ~/ 10) + 1;
  String get progres => 'N°${_currentIndex + 1} sur $_max';

  QuestionResultModel? get question => _questions[_currentIndex];

  void _fetchQuestions(List<QuestionResultModel> questions,
      {required int page}) {
    final start = (page - 1) * 10;
    final end = start + 10 >= _max ? _max : start + 10;

    for (var i = start; i < end; i++) {
      _questions[i] = questions[i - start];
    }
  }

  factory QuestionState.initial(int max, List<int> correctIndexes,
          List<int> wrongIndexes) =>
      QuestionState(
        questions: List.filled(max, null),
        max: max,
        correctIndexes: correctIndexes,
        wrongIndexes: wrongIndexes,
      );

  QuestionState _answerQuestion(List<String> choices) {
    _questions[_currentIndex] =
        _questions[_currentIndex]!.answerWith(choices);
    return _copyWith(questions: _questions);
  }

  QuestionState _saveTime(int time) {
    if (question == null) return this;
    _questions[_currentIndex] =
        _questions[_currentIndex]!.saveTime(time);

    return _copyWith(questions: _questions);
  }

  QuestionState _toQuestion(int index) =>
      _copyWith(currentIndex: index);

  QuestionState _errorOccured(String error) =>
      _copyWith(error: error);

  QuestionState _copyWith({
    List<QuestionResultModel?>? questions,
    int? currentIndex,
    String? error,
  }) {
    return QuestionState(
      questions: questions ?? _questions,
      currentIndex: currentIndex ?? _currentIndex,
      error: error,
      max: _max,
    );
  }
}

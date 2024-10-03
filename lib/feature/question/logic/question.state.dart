part of 'questions.cubit.dart';

class QuestionState extends ErrorState {
  final List<QuestionResultModel?> questions;
  final int? _currentIndex;
  final int subIndex;
  final int max;
  final List<int> _correctIndexes;
  final Map<int, List<int>> _wrongIndexes;

  QuestionState({
    required this.questions,
    int? currentIndex,
    this.subIndex = 0,
    required this.max,
    String? error,
    List<int>? correctIndexes,
    Map<int, List<int>>? wrongIndexes,
  })  : _currentIndex = currentIndex,
        _correctIndexes = correctIndexes ?? [],
        _wrongIndexes = wrongIndexes ?? {},
        super(error);

  factory QuestionState.initial(int max, List<int>? correctIndexes,
          Map<int, List<int>>? wrongIndexes) =>
      QuestionState(
        questions: List.filled(max, null),
        max: max,
        correctIndexes: correctIndexes,
        wrongIndexes: wrongIndexes,
      );

  QuestionResultModel? get question => questions[_currentIndex ?? 0];

  bool isExists(int index) => questions[index] != null;
  bool isCurrent(int index) => _currentIndex == index;

  bool isAnswered(int index) =>
      _correctIndexes.contains(index) ||
      _wrongIndexes.containsKey(index);

  bool isCorrect(int index) => _correctIndexes.contains(index);
  int questionMax(int index) =>
      questions[index]?.question.questions?.length ?? 1;

  bool isSubCorrect(QuestionResultModel question, int index) =>
      _correctIndexes.contains(questions.indexOf(question)) ||
      _wrongIndexes[questions.indexOf(question)]?.contains(index) ==
          true;

  bool isSubCorrectIndex(int quesion, int index) =>
      _correctIndexes.contains(quesion) ||
      _wrongIndexes[quesion]?.contains(index) == true;

  String get progress => 'N°${_currentIndex! + 1} sur $max';

  void _fetchQuestions(List<QuestionResultModel> questions,
      {required int page}) {
    final start = (page - 1) * 10;
    final end = start + 10 >= max ? max : start + 10;

    for (var i = start; i < end; i++) {
      this.questions[i] = questions[i - start];
    }
  }

  void _saveTime(int time) {
    questions[_currentIndex!] =
        questions[_currentIndex]?.saveTime(time);
  }

  QuestionState _answerQuestion(List<List<int>> choices)  {
    questions[_currentIndex!] =
        questions[_currentIndex]!.answer(choices);

    if (questions[_currentIndex]!.result.isAllCorrect) {
      _correctIndexes.add(_currentIndex);
    } else {
      _wrongIndexes[_currentIndex] =
          questions[_currentIndex]!.result.correctIndexes;
    }

    return _copyWith();
  }

  QuestionState _toQuestion(int index) =>
      _copyWith(currentIndex: index);
  QuestionState _toSubQuestion(int index) =>
      _copyWith(subIndex: index);

  QuestionState _errorOccured(String error) =>
      _copyWith(error: error);

  QuestionState _copyWith({
    List<QuestionResultModel?>? questions,
    int? currentIndex,
    String? error,
    int? subIndex,
  }) {
    return QuestionState(
      subIndex:
          currentIndex != null ? 0 : (subIndex ?? this.subIndex),
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? _currentIndex,
      wrongIndexes: _wrongIndexes,
      correctIndexes: _correctIndexes,
      error: error,
      max: max,
    );
  }
}

// class QuestionState extends ErrorState {
//   QuestionState({
//     required List<QuestionResultModel?> questions,
//     int currentIndex = 0,
//     required int max,
//     String? error,
//     List<int>? correctIndexes,
//     List<int>? wrongIndexes,
//   })  : _max = max,
//         _currentIndex = currentIndex,
//         _questions = questions,
//         _correctIndexes = correctIndexes ?? [],
//         _wrongIndexes = wrongIndexes ?? [],
//         super(error);

//   final List<QuestionResultModel?> _questions;
//   final int _currentIndex;
//   final int _max;
//   final List<int> _correctIndexes;
//   final List<int> _wrongIndexes;

//   List<QuestionResultModel?> get questions => _questions;

//   bool exists(int index) => _questions[index] != null;
//   bool isAnswered(int index) =>
//       _questions[index]?.result.isAnswerd == true ||
//       _correctIndexes.contains(index) ||
//       _wrongIndexes.contains(index);

//   bool isCorrect(int index) =>
//       _questions[index]?.result.isCorrect == true ||
//       _correctIndexes.contains(index);

//   bool isCurrent(int index) => _currentIndex == index;

//   int get max => _max;

//   int page(int index) => (index ~/ 10) + 1;
//   String get progres => 'N°${_currentIndex + 1} sur $_max';

//   QuestionResultModel? get question => _questions[_currentIndex];

//   void _fetchQuestions(List<QuestionResultModel> questions,
//       {required int page}) {
//     final start = (page - 1) * 10;
//     final end = start + 10 >= _max ? _max : start + 10;

//     for (var i = start; i < end; i++) {
//       _questions[i] = questions[i - start];
//     }
//   }

//   factory QuestionState.initial(int max, List<int> correctIndexes,
//           List<int> wrongIndexes) =>
//       QuestionState(
//         questions: List.filled(max, null),
//         max: max,
//         correctIndexes: correctIndexes,
//         wrongIndexes: wrongIndexes,
//       );

//   QuestionState _answerQuestion(List<String> choices) {
//     _questions[_currentIndex] =
//         _questions[_currentIndex]!.answerWith(choices);
   
//     return _copyWith(questions: _questions);
//   }

  // QuestionState _saveTime(int time) {
  //   if (question == null) return this;
  //   _questions[_currentIndex] =
  //       _questions[_currentIndex]!.saveTime(time);

  //   return _copyWith(questions: _questions);
  // }

//   QuestionState _toQuestion(int index) =>
//       _copyWith(currentIndex: index);

//   QuestionState _errorOccured(String error) =>
//       _copyWith(error: error);

//   QuestionState _copyWith({
//     List<QuestionResultModel?>? questions,
//     int? currentIndex,
//     String? error,
//   }) {
//     return QuestionState(
//       questions: questions ?? _questions,
//       currentIndex: currentIndex ?? _currentIndex,
//       error: error,
//       max: _max,
//     );
//   }
// }

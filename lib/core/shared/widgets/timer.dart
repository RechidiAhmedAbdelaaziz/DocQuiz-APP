import 'dart:async';
import 'package:app/core/extension/to_time.extension.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerState {
  final int seconds;
  final TimerType _type;

  TimerState._({
    required this.seconds,
    required TimerType type,
  }) : _type = type;

  factory TimerState._initial({int? time}) => time != null
      ? TimerState._countdown(time)
      : TimerState._stopwatch();

  factory TimerState._countdown(int time) =>
      TimerState._(seconds: time, type: TimerType.countdown);

  factory TimerState._stopwatch() =>
      TimerState._(seconds: 0, type: TimerType.stopwatch);

  TimerState updateTimer({int? newTime}) => _copyWith(
        seconds: _type == TimerType.countdown
            ? seconds - 1
            : newTime ?? seconds + 1,
      );

  TimerState _copyWith({
    int? seconds,
    TimerType? type,
  }) {
    return TimerState._(
      seconds: seconds ?? this.seconds,
      type: type ?? this._type,
    );
  }

  void onEnd(void Function() onEnd) {
    if (seconds == 0 && _type == TimerType.countdown) onEnd();
  }
}

//* TimerCubit

class TimeCubit extends Cubit<TimerState> {
  final int? time;

  TimeCubit({this.time}) : super(TimerState._initial(time: time)) {
    start();
  }

  Timer? _timer;

  void _onTick(Timer timer) {
    emit(state.updateTimer());
    state.onEnd(() {
      timer.cancel();
    });
  }

  void start({int? newTime}) {
    if (_timer != null) _timer!.cancel();

    emit(state.updateTimer(newTime: newTime));

    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void pause() => _timer!.cancel();

  void stopWhenStopwatch() =>
      state._type == TimerType.countdown ? null : _timer!.cancel();

  @override
  Future<void> close() {
    _timer!.cancel();
    return super.close();
  }
}

enum TimerType {
  countdown,
  stopwatch,
}

class AppTimer extends StatelessWidget {
  const AppTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TimeCubit>().state;
    final time = context.read<TimeCubit>().time;

    final color = state._type == TimerType.countdown
        ? state.seconds < time! / 8
            ? Colors.red
            : state.seconds < time / 4
                ? Colors.orange
                : Colors.teal
        : state.seconds > 180
            ? Colors.red
            : state.seconds > 60
                ? Colors.orange
                : Colors.teal;

    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      color: color,
      alignment: Alignment.center,
      child: Text(
        state.seconds >= 3600
            ? state.seconds.toTimeHourMinuteSecond
            : state.seconds.toTimeMinuteSecond,
        style: context.textStyles.h3.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

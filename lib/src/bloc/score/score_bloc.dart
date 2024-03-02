import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'score_state.dart';

class ScoreBloc extends Cubit<ScoreState> {
  ScoreBloc() : super(const ScoreState());

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final String _dataKey = "rnjg-data";

  void init() async {
    final pref = await _pref;
    final data = json.decode(pref.getString(_dataKey) ?? "{}");

    emit(
      ScoreState(
        enemiesKilled: data['enemiesKilled'] ?? 0,
        maxEnemiesKilled: data['maxEnemiesKilled'] ?? 0,
        maxLvl: data['maxScore'] ?? 0,
        maxScore: data['maxLvl'] ?? 0,
      ),
    );
  }

  void updateData({
    required int enemiesKilled,
    required int score,
    required int lvl,
  }) async {
    final newEnemiesKilled = state.enemiesKilled + enemiesKilled;
    final newMaxEnemiesKilled = state.maxEnemiesKilled < enemiesKilled
        ? enemiesKilled
        : state.maxEnemiesKilled;
    final newMaxLvl = state.maxLvl < lvl ? lvl : state.maxLvl;
    final newMaxScore = state.maxScore < score ? score : state.maxScore;

    emit(
      ScoreState(
        enemiesKilled: newEnemiesKilled,
        maxEnemiesKilled: newMaxEnemiesKilled,
        maxLvl: newMaxLvl,
        maxScore: newMaxScore,
      ),
    );
  }
}

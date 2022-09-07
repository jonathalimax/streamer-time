// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streamer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StreamerStore on _StreamerStore, Store {
  late final _$streamersAtom =
      Atom(name: '_StreamerStore.streamers', context: context);

  @override
  ObserverList<User> get streamers {
    _$streamersAtom.reportRead();
    return super.streamers;
  }

  @override
  set streamers(ObserverList<User> value) {
    _$streamersAtom.reportWrite(value, super.streamers, () {
      super.streamers = value;
    });
  }

  late final _$_StreamerStoreActionController =
      ActionController(name: '_StreamerStore', context: context);

  @override
  void add(User streamer) {
    final _$actionInfo = _$_StreamerStoreActionController.startAction(
        name: '_StreamerStore.add');
    try {
      return super.add(streamer);
    } finally {
      _$_StreamerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void set(List<User> allStreamers) {
    final _$actionInfo = _$_StreamerStoreActionController.startAction(
        name: '_StreamerStore.set');
    try {
      return super.set(allStreamers);
    } finally {
      _$_StreamerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeById(String streamerId) {
    final _$actionInfo = _$_StreamerStoreActionController.startAction(
        name: '_StreamerStore.removeById');
    try {
      return super.removeById(streamerId);
    } finally {
      _$_StreamerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
streamers: ${streamers}
    ''';
  }
}

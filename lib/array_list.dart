/// [Array] and [ArrayList] wrappers for the system default [List].

library array_list;

import 'dart:math' show Random;

/// A wrapper for the fixed-length system [List] implementation.
class Array<T> extends _DelegatingList<T> {
  // dart2js infers that [_list] is a fixed-length list implemented by a
  // JavaScript Array.
  final List<T> _list;

  Array(int size) : _list = new List<T>(size);

  // TODO(sra): Add Array.from, Array.filled, Array.generate.  These are
  // difficult because a naive implementation delegates to a [List] constructor
  // with a `growable:` parameter. dart2js does not know if the list returned by
  // these constructors is growable for fixed-length.

  // `_list.sublist()` is a growable list.
  // Perhaps we should return a
  ArrayList<T> sublist(int start, [int end]) =>
      new ArrayList<T>._(_list.sublist(start, end));
}

/// A wrapper for the growable system [List] implemenation.
class ArrayList<T> extends _DelegatingList<T> {
  // dart2js infers that [_list] is a growable list implemented by a JavaScript
  // Array.
  final List<T> _list;

  ArrayList._(this._list);

  ArrayList() : _list = <T>[];

  // TODO(sra): Add ArrayList.from, ArrayList.filled, ArrayList.generate.  These
  // are difficult because a naive implementation delegates to a [List]
  // constructor with a `growable:` parameter. dart2js does not know if the list
  // returned by these constructors is growable for fixed-length.

  ArrayList<T> sublist(int start, [int end]) =>
      new ArrayList<T>._(_list.sublist(start, end));
}

/// Common code to delegate to the system list.
abstract class _DelegatingList<E> implements List<E> {
  List<E> get _list;

  /// Escape hatch to access underlying elements.
  ///
  /// [elements] is required when passing an [Array] or [ArrayList] to
  /// JavaScript via interop.
  ///
  /// Also useful for for-in:
  ///
  ///     Array a = ...
  ///     for (var e in a.elements) ...  // generates indexing loop.
  ///     for (var e in a) ...           // generates iterator loop.
  ///
  List<E> get elements => _list;

  E operator [](int i) => _list[i];
  void operator []=(int i, E e) {
    _list[i] = e;
  }

  int get length => _list.length;
  void set length(int n) {
    _list.length = n;
  }

  E elementAt(int index) => _list.elementAt(index);
  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  Iterator<E> get iterator => _list.iterator;

  E get first => _list.first;
  E get last => _list.last;
  E get single => _list.single;

  // TODO(sra): Should this return an Array or ArrayList instead?
  List<E> toList({growable: true}) => _list.toList(growable: growable);

  Set<E> toSet() => _list.toSet();

  bool any(bool test(E element)) => _list.any(test);
  bool every(bool test(E element)) => _list.every(test);

  Iterable<T> map<T>(T f(E e)) => _list.map(f);
  Iterable<E> where(bool test(E element)) => _list.where(test);
  String join([String separator = ""]) => _list.join(separator);

  Iterable<E> skip(int count) => _list.skip(count);
  Iterable<E> skipWhile(bool test(E value)) => _list.skipWhile(test);
  Iterable<E> take(int count) => _list.take(count);
  Iterable<E> takeWhile(bool test(E value)) => _list.takeWhile(test);

  T fold<T>(T initialValue, T combine(T previous, E element)) =>
      _list.fold(initialValue, combine);

  E reduce(E combine(E value, E element)) => _list.reduce(combine);

  Iterable<T> expand<T>(Iterable<T> f(E element)) => _list.expand(f);

  void add(E e) {
    _list.add(e);
  }

  E removeLast() => _list.removeLast();
  void insert(int index, E element) {
    _list.insert(insert, element);
  }

  void addAll(Iterable<E> iterable) {
    _list.addAll(iterable);
  }

  void setAll(int index, Iterable<E> iterable) {
    _list.setAll(index, iterable);
  }

  void insertAll(int index, Iterable<E> iterable) {
    _list.insertAll(index, iterable);
  }

  void clear() {
    _list.clear();
  }

  int indexOf(E element, [int start = 0]) => _list.indexOf(element, start);
  int lastIndexOf(E element, [int start = 0]) =>
      _list.lastIndexOf(element, start);

  bool contains(Object o) => _list.contains(o);
  bool remove(Object o) => _list.remove(o);
  E removeAt(int index) => _list.removeAt(index);
  void removeWhere(bool test(E element)) {
    _list.removeWhere(test);
  }

  void retainWhere(bool test(E element)) {
    _list.retainWhere(test);
  }

  E firstWhere(bool test(E element), {E orElse()}) =>
      _list.firstWhere(test, orElse: orElse);
  E lastWhere(bool test(E element), {E orElse()}) =>
      _list.lastWhere(test, orElse: orElse);
  E singleWhere(bool test(E element)) => _list.singleWhere(test);

  void forEach(void action(E e)) => _list.forEach(action);

  Iterable<E> getRange(int start, int end) => _list.getRange(start, end);
  void fillRange(int start, int end, [E fillValue]) {
    _list.fillRange(start, end, fillValue);
  }

  void removeRange(int start, int end) {
    _list.removeRange(start, end);
  }

  void replaceRange(int start, int end, Iterable<E> replacement) {
    _list.replaceRange(start, end, replacement);
  }

  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    _list.setRange(start, end, iterable, skipCount);
  }

  void sort([int compare(E a, E b)]) {
    _list.sort(compare);
  }

  void shuffle([Random random]) {
    _list.shuffle(random);
  }

  Iterable<E> get reversed => _list.reversed;
  Map<int, E> asMap() => _list.asMap();
}

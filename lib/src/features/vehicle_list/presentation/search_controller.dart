import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchInputNotifer extends AutoDisposeNotifier<String> {
  // Timer? _debounceTimer;

  @override
  String build() {
    return "";
  }

  setSearchQuery({required String query}) {
    // log('debounce query: $query');

    // if (_debounceTimer != null) {
    //   _debounceTimer!.cancel();
    // }
    // _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
    //   log('debounce state: $query');
    // only update the state once the query has been debounced
    state = query;
  }

  clear() {
    // if (_debounceTimer != null) {
    //   _debounceTimer!.cancel();
    // }
    // _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
    state = "";
    // });
  }
}

final searchProvider =
    NotifierProvider.autoDispose<SearchInputNotifer, String>(() {
  return SearchInputNotifer();
});

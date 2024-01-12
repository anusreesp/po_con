
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GuestTab {all, checkedIn, waiting}

final tabController = StateProvider<GuestTab>((ref) => GuestTab.all);
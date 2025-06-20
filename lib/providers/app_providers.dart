
import 'package:himmah_tracker/modules/user.dart';
import 'package:riverpod/riverpod.dart';

final currentUserProvider = StateProvider<User?>((ref)=> null);
final campaignIDProvider = StateProvider<int?>((ref)=> null);
final groupIDProvider = StateProvider<int?>((ref)=> null);
final tockenProvider = StateProvider<String?>((ref)=> null);
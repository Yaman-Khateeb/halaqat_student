import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himmah_tracker/providers/app_providers.dart';
import 'package:himmah_tracker/services/groups_api.dart';
import 'package:himmah_tracker/widgets/group_card.dart';

class SelectGroupScreen extends ConsumerStatefulWidget {
  const SelectGroupScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<SelectGroupScreen> createState() => _SelectGroupScreenState();
}

class _SelectGroupScreenState extends ConsumerState<SelectGroupScreen> {
  late final int studentId;
  late final int campaignId;
  bool isLoading = true;
  bool hasError = false;
  List<Map<String, dynamic>>? groups;

  
  bool _initialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) //We only want to do this once not every time
    {
      studentId = ref.watch(currentUserProvider)!.id;
      campaignId = ref.watch(campaignIDProvider)!;
      _initialized = true;
       fetchGroups();
    }
  }

  Future<void> fetchGroups() async {
    try {
      final result = await GroupsApi().getGroupsForStudentAndCampaign(
        studentId,
        campaignId,
      );
      setState(() {
        groups = result;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      debugPrint('[SelectGroup] ❗ Error: $e');
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (hasError || groups == null || groups!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('لم يتم إيجاد أي مجموعة'),
          centerTitle: true,
        ),
        body: const Center(child: Text('حدث خطأ، الرجاء المحاولة لاحقاً')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('اختر المجموعة'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: groups!.length,
        itemBuilder: (context, index) {
          final group = groups![index];
          return GroupCard(group);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:himmah_tracker/services/groups_api.dart';
import 'package:himmah_tracker/widgets/group_card.dart';

class SelectGroupScreen extends StatefulWidget {
  final int studentId;
  final int campaignId;

  const SelectGroupScreen({
    Key? key,
    required this.studentId,
    required this.campaignId,
  }) : super(key: key);

  @override
  State<SelectGroupScreen> createState() => _SelectGroupScreenState();
}

class _SelectGroupScreenState extends State<SelectGroupScreen> {
  bool isLoading = true;
  bool hasError = false;
  List<Map<String, dynamic>>? groups;

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    try {
      final result = await GroupsApi()
          .getGroupsForStudentAndCampaign(widget.studentId, widget.campaignId);
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (hasError || groups == null || groups!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('لم يتم إيجاد أي مجموعة'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('حدث خطأ، الرجاء المحاولة لاحقاً'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر المجموعة'),
        centerTitle: true,
      ),
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

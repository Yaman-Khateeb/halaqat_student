import 'package:flutter/material.dart';
import 'package:himmah_tracker/services/campaigns_api.dart';
import 'package:himmah_tracker/widgets/campaign.dart';

class SelectCampaignScreen extends StatefulWidget {
  const SelectCampaignScreen({super.key});

  @override
  State<SelectCampaignScreen> createState() => _SelectCampaignScreenState();
}

class _SelectCampaignScreenState extends State<SelectCampaignScreen> {
  bool isLoading = true;
  bool hasError = false;
  List<Map<String, dynamic>>? campaigns;
  Future<void> fetchCampaigns() async {
  debugPrint('[SelectCampaign] 🔄 Fetching campaigns...');
  try {
    final result = await CampaignsApi().getCampaignsForStudentID(1);
    debugPrint('[SelectCampaign] ✅ Received: $result');

    setState(() {
      campaigns = result;
      isLoading = false;
      hasError = false;
    });
  } catch (e) {
    debugPrint('[SelectCampaign] ❗ Error: $e');
    setState(() {
      hasError = true;
      isLoading = false;
    });
  }
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     fetchCampaigns();
  }
  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> dummyCampaigns = [
    //   {
    //     "id": 1,
    //     "name": "الدورة الصيفية 2025",
    //     "days": "سبت,إثنين,أربعاء",
    //     "startTime": "15:00",
    //     "endTime": "17:00",
    //     "status": true,
    //   },
    //   {
    //     "id": 2,
    //     "name": "الدورة الشتوية 2024",
    //     "days": "أحد,ثلاثاء,خميس",
    //     "startTime": "16:00",
    //     "endTime": "18:00",
    //     "status": false,
    //   },
    // ];

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (hasError || campaigns == null || campaigns!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('لم يتم إيجاد أي دورة'),
          centerTitle: true,
        ),
        body: const Center(child: Text('حدث خطأ، الرجاء المحاولة لاحقاً')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('اختر الدورة'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: campaigns!.length,
        itemBuilder: (context, index) {
          final campaign = campaigns![index];

          return CampaignCard(campaign);
        },
      ),
    );
  }
}

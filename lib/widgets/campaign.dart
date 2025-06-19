import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CampaignCard extends StatelessWidget {
  const CampaignCard(this.campaign,{super.key});
  final Map<String, dynamic> campaign;
  


  @override
  Widget build(BuildContext context) {
                final bool isActive = campaign["status"] == true;
          final Color cardColor =
              isActive ? const Color.fromARGB(255, 211, 243, 244)! : const Color.fromARGB(226, 226, 229, 236)!;
          final Color statusColor = isActive ? Colors.lightBlue : Colors.grey;
    
    return  Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  campaign["name"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'الأيام: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${campaign["days"]}',
                          // Optional: you can set a normal style or leave it as default
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text.rich(
                      TextSpan
                      (
                        children: [
                          const TextSpan( text: 'الوقت: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text:'${campaign['startTime']} - ${campaign['endTime']}'),
                        ]
                      )
                  ),
                  
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isActive ? "الدورة قائمة" : "منتهية",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              onTap: () async{
                // TODO: Store campaign in SharedPreferences and navigate
                final preference = await SharedPreferences.getInstance();
                preference.setInt('campaign_id', campaign['id']);
                print('Save to preferences : ${preference.get('campaign_id')}');
              },
            ),
          );
  }
}
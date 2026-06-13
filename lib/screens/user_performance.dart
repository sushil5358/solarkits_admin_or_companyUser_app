// lib/screens/user_performance_report_screen.dart
import 'package:flutter/material.dart';


class UserPerformanceReportScreen extends StatelessWidget {
  const UserPerformanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('User Performance Reports'),
          bottom: const TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Leaderboard'),
              Tab(text: 'Conversion'),
              Tab(text: 'Revenue'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {},
              tooltip: 'Download Report',
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {},
              tooltip: 'Select Date Range',
            ),
          ],
        ),
        body: Column(
          children: [
            // Date Range Selector
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   color: Colors.white,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: _buildDateSelector('Start Date', 'Mar 01, 2024'),
            //       ),
            //       const SizedBox(width: 12),
            //       Expanded(
            //         child: _buildDateSelector('End Date', 'Mar 13, 2024'),
            //       ),
            //       const SizedBox(width: 12),
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Colors.green,
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: IconButton(
            //           icon: const Icon(Icons.refresh, color: Colors.white),
            //           onPressed: () {},
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Summary Cards
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildSummaryCard(
                    'Active Users',
                    '142',
                    '↑ 12',
                    Icons.people,
                    Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildSummaryCard(
                    'Total Actions',
                    '2,847',
                    '↑ 23%',
                    Icons.analytics,
                    Colors.green,
                  ),
                  const SizedBox(width: 12),
                  _buildSummaryCard(
                    'Conversion Rate',
                    '68.5%',
                    '↑ 5.2%',
                    Icons.trending_up,
                    Colors.orange,
                  ),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  _buildOverviewTab(),
                  _buildLeaderboardTab(),
                  _buildConversionTab(),
                  _buildRevenueTab(),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget _buildDateSelector(String label, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Icon(Icons.calendar_today, size: 16, color: Colors.green.shade600),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String change, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: change.startsWith('↑') ? Colors.green.shade50 : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      color: change.startsWith('↑') ? Colors.green.shade700 : Colors.red.shade700,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Overview Tab
  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Performance Chart Placeholder
        // Container(
        //   height: 200,
        //   padding: const EdgeInsets.all(16),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Text(
        //         'User Activity Trend',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16,
        //         ),
        //       ),
        //       const SizedBox(height: 8),
        //       // Expanded(
        //       //   child: Row(
        //       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       //     children: List.generate(7, (index) {
        //       //       return Column(
        //       //         mainAxisAlignment: MainAxisAlignment.end,
        //       //         children: [
        //       //           Container(
        //       //             width: 30,
        //       //             height: 80 + (index * 20).toDouble(),
        //       //             decoration: BoxDecoration(
        //       //               gradient: LinearGradient(
        //       //                 begin: Alignment.bottomCenter,
        //       //                 end: Alignment.topCenter,
        //       //                 colors: [
        //       //                   Colors.green.shade300,
        //       //                   Colors.green.shade600,
        //       //                 ],
        //       //               ),
        //       //               borderRadius: BorderRadius.circular(8),
        //       //             ),
        //       //           ),
        //       //           const SizedBox(height: 8),
        //       //           Text(
        //       //             ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
        //       //             style: TextStyle(
        //       //               color: Colors.grey.shade600,
        //       //               fontSize: 12,
        //       //             ),
        //       //           ),
        //       //         ],
        //       //       );
        //       //     }),
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),

        const SizedBox(height: 16),

        // Top Users This Week
        const Text(
          'Top Users This Week',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildUserPerformanceCard(
          rank: 1,
          name: 'Sarah Smith',
          avatar: 'SS',
          color: Colors.amber,
          stats: {
            'Leads': 45,
            'Quotes': 38,
            'Projects': 32,
            'Revenue': '₨ 2.4M',
          },
          trend: 15,
        ),

        _buildUserPerformanceCard(
          rank: 2,
          name: 'John Doe',
          avatar: 'JD',
          color: Colors.blue,
          stats: {
            'Leads': 38,
            'Quotes': 32,
            'Projects': 28,
            'Revenue': '₨ 1.9M',
          },
          trend: 8,
        ),

        _buildUserPerformanceCard(
          rank: 3,
          name: 'Mike Johnson',
          avatar: 'MJ',
          color: Colors.purple,
          stats: {
            'Leads': 32,
            'Quotes': 28,
            'Projects': 24,
            'Revenue': '₨ 1.6M',
          },
          trend: 5,
        ),

        _buildUserPerformanceCard(
          rank: 4,
          name: 'Emily Brown',
          avatar: 'EB',
          color: Colors.orange,
          stats: {
            'Leads': 28,
            'Quotes': 24,
            'Projects': 20,
            'Revenue': '₨ 1.2M',
          },
          trend: -2,
        ),
      ],
    );
  }

  Widget _buildUserPerformanceCard({
    required int rank,
    required String name,
    required String avatar,
    required Color color,
    required Map<String, dynamic> stats,
    required int trend,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Rank Badge
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: rank == 1
                      ? Colors.amber.shade100
                      : rank == 2
                      ? Colors.grey.shade200
                      : Colors.brown.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '#$rank',
                    style: TextStyle(
                      color: rank == 1
                          ? Colors.amber.shade800
                          : rank == 2
                          ? Colors.grey.shade700
                          : Colors.brown.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    avatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Name and Trend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          trend >= 0 ? Icons.trending_up : Icons.trending_down,
                          color: trend >= 0 ? Colors.green : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${trend >= 0 ? '+' : ''}$trend% from last week',
                          style: TextStyle(
                            color: trend >= 0 ? Colors.green : Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Star for top performer
              if (rank == 1)
                Icon(Icons.emoji_events, color: Colors.amber.shade600),
            ],
          ),

          const SizedBox(height: 16),

          // Stats Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Leads', stats['Leads'].toString(), Icons.leaderboard),
              _buildStatItem('Quotes', stats['Quotes'].toString(), Icons.receipt),
              _buildStatItem('Projects', stats['Projects'].toString(), Icons.solar_power),
              _buildStatItem('Revenue', stats['Revenue'].toString(), Icons.attach_money),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: Colors.green.shade600),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // Leaderboard Tab
  Widget _buildLeaderboardTab() {
    final List<Map<String, dynamic>> allUsers = [
      {'rank': 1, 'name': 'Sarah Smith', 'points': 210, 'badge': '🏆', 'department': 'Freelancer'},
      {'rank': 2, 'name': 'John Doe', 'points': 165, 'badge': '🥈', 'department': 'Chhanel Partner'},
      {'rank': 3, 'name': 'Mike Johnson', 'points': 130, 'badge': '🥉', 'department': 'Premium dealer'},
      {'rank': 4, 'name': 'Emily Brown', 'points': 110, 'badge': '⭐', 'department': 'Premium dealer'},
      {'rank': 5, 'name': 'David Wilson', 'points': 80, 'badge': '⭐', 'department': 'Freelancer'},
      {'rank': 6, 'name': 'Lisa Anderson', 'points': 60, 'badge': '⭐', 'department': 'Support'},
      {'rank': 7, 'name': 'Robert Taylor', 'points': 50, 'badge': '⭐', 'department': 'Support'},
      {'rank': 8, 'name': 'Maria Garcia', 'points': 45, 'badge': '⭐', 'department': 'Support'},
    ];

    return Column(
      children: [
        // Podium
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Second Place
              _buildPodiumItem(
                rank: 2,
                name: 'John Doe',
                points: '165 KW',
                height: 80,
                color: Colors.grey.shade400,
              ),
              const SizedBox(width: 10),
              // First Place
              _buildPodiumItem(
                rank: 1,
                name: 'Sarah Smith',
                points: '210 KW',
                height: 120,
                color: Colors.amber,
              ),
              const SizedBox(width: 10),
              // Third Place
              _buildPodiumItem(
                rank: 3,
                name: 'Mike Johnson',
                points: '130 KW',
                height: 60,
                color: Colors.brown.shade300,
              ),
            ],
          ),
        ),

        // Leaderboard List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: allUsers.length,
            itemBuilder: (context, index) {
              final user = allUsers[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: user['rank'] <= 3
                      ? Border.all(color: Colors.green.shade200, width: 2)
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: user['rank'] <= 3
                            ? Colors.green.shade100
                            : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          user['badge'] ?? '#${user['rank']}',
                          style: TextStyle(
                            fontSize: user['rank'] <= 3 ? 16 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user['department'],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${user['points']} KW',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        Text(
                          'performance',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPodiumItem({
    required int rank,
    required String name,
    required String points,
    required double height,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border.all(color: color, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '#$rank',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                points,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name.split(' ')[0],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // Conversion Tab
  Widget _buildConversionTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Conversion Funnel
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Conversion Funnel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              _buildFunnelStage('Leads → Quotes', '68%', 0.68, Colors.blue),
              _buildFunnelStage('Quotes → Projects', '82%', 0.82, Colors.green),
              _buildFunnelStage('Projects → Completed', '76%', 0.76, Colors.orange),
              _buildFunnelStage('Overall Conversion', '42%', 0.42, Colors.purple),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // User Conversion Rates
        const Text(
          'User Conversion Rates',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildConversionRateCard(
          name: 'Sarah Smith',
          leads: 45,
          quotes: 38,
          projects: 32,
          conversionRate: 71,
        ),
        _buildConversionRateCard(
          name: 'John Doe',
          leads: 38,
          quotes: 32,
          projects: 28,
          conversionRate: 74,
        ),
        _buildConversionRateCard(
          name: 'Mike Johnson',
          leads: 32,
          quotes: 28,
          projects: 24,
          conversionRate: 75,
        ),
        _buildConversionRateCard(
          name: 'Emily Brown',
          leads: 28,
          quotes: 22,
          projects: 18,
          conversionRate: 64,
        ),
      ],
    );
  }

  Widget _buildFunnelStage(String label, String percentage, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),
              Text(
                percentage,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionRateCard({
    required String name,
    required int leads,
    required int quotes,
    required int projects,
    required int conversionRate,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildMetricChip('Leads', leads.toString()),
                        const SizedBox(width: 8),
                        _buildMetricChip('Quotes', quotes.toString()),
                        const SizedBox(width: 8),
                        _buildMetricChip('Projects', projects.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: conversionRate >= 70
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$conversionRate%',
                  style: TextStyle(
                    color: conversionRate >= 70
                        ? Colors.green.shade700
                        : Colors.orange.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$value $label',
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 10,
        ),
      ),
    );
  }

  // Revenue Tab
  Widget _buildRevenueTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Revenue Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade800],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Text(
                'Total Revenue Generated',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '₨ 12,450,000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRevenueStat('This Month', '₨ 2.4M', '+15%'),
                  _buildRevenueStat('Last Month', '₨ 2.1M', '+8%'),
                  _buildRevenueStat('Avg/User', '₨ 87.6K', '+12%'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Revenue by User
        const Text(
          'Revenue by User',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRevenueUserCard(
          rank: 1,
          name: 'Sarah Smith',
          revenue: '₨ 2,450,000',
          deals: 32,
          commission: '₨ 245,000',
          progress: 0.95,
        ),
        _buildRevenueUserCard(
          rank: 2,
          name: 'John Doe',
          revenue: '₨ 1,890,000',
          deals: 28,
          commission: '₨ 189,000',
          progress: 0.82,
        ),
        _buildRevenueUserCard(
          rank: 3,
          name: 'Mike Johnson',
          revenue: '₨ 1,560,000',
          deals: 24,
          commission: '₨ 156,000',
          progress: 0.71,
        ),
        _buildRevenueUserCard(
          rank: 4,
          name: 'Emily Brown',
          revenue: '₨ 1,230,000',
          deals: 20,
          commission: '₨ 123,000',
          progress: 0.64,
        ),

        const SizedBox(height: 20),

        // Revenue Chart
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monthly Revenue Trend',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRevenueBar('Jan', 0.6, '₨ 1.2M'),
                    _buildRevenueBar('Feb', 0.7, '₨ 1.4M'),
                    _buildRevenueBar('Mar', 0.85, '₨ 1.7M'),
                    _buildRevenueBar('Apr', 0.9, '₨ 1.8M'),
                    _buildRevenueBar('May', 1.0, '₨ 2.0M'),
                    _buildRevenueBar('Jun', 0.95, '₨ 1.9M'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueStat(String label, String value, String change) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
        Text(
          change,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueUserCard({
    required int rank,
    required String name,
    required String revenue,
    required int deals,
    required String commission,
    required double progress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: rank == 1
                      ? Colors.amber.shade100
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '#$rank',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: rank == 1 ? Colors.amber.shade800 : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$deals deals closed',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    revenue,
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Commission: $commission',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(
              rank == 1 ? Colors.amber : Colors.green,
            ),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Target: ₨ 2.5M',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 10,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% achieved',
                style: TextStyle(
                  color: Colors.green.shade600,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueBar(String month, double heightFactor, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 100 * heightFactor,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.green.shade300,
                Colors.green.shade600,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Transform.rotate(
              angle: -1.57,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
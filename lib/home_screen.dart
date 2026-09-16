import 'package:ariston/app_wordmark.dart';
import 'package:ariston/bottom_nav_bar.dart';
import 'package:ariston/responsive_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  // TO be improved on
  final String _userName = 'Tosin';
  final int _streak = 12;
  final int _coins = 500;
  final double _mastery = 0.45;

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      backgroundColor: const Color(0xFFF7F8FC),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppWordmark(),
              Row(
                children: [
                  _StatChip(icon: Icons.local_fire_department, value: '$_streak', color: const Color(0xFFD9622B), bg: const Color(0xFFFFECE0)),
                  const SizedBox(width: 6),
                  _StatChip(icon: Icons.monetization_on, value: '$_coins', color: const Color(0xFFB8860B), bg: const Color(0xFFFFF2CF)),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color(0xFF003FB1),
                    child: Text(
                      _userName.isNotEmpty ? _userName[0] : '?',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text('Hello, $_userName!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          const Text(
            'Ready to dominate the leaderboard today?',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF5A6178)),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  label: 'Start Practice',
                  icon: Icons.play_arrow_rounded,
                  colors: const [Color(0xFF2757E0), Color(0xFF0F2F7A)],
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  label: 'Find Duel',
                  icon: Icons.sports_kabaddi,
                  colors: const [Color(0xFFD62839), Color(0xFFB81F2E)],
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ContinuePracticingCard(mastery: _mastery),
          const SizedBox(height: 14),
          const _UpcomingEventCard(),
          const SizedBox(height: 18),
          Row(
            children: const [
              Icon(Icons.notifications_none, size: 18, color: Colors.black),
              SizedBox(width: 6),
              Text('Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 10),
          const _NotificationItem(text: 'Daniel sent you a message'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;
  final Color bg;

  const _StatChip({required this.icon, required this.value, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 3),
          Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onTap;

  const _ActionCard({required this.label, required this.icon, required this.colors, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinuePracticingCard extends StatelessWidget {
  final double mastery;
  const _ContinuePracticingCard({required this.mastery});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6FF),
        border: Border.all(color: const Color(0xFFE3ECFF)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.menu_book_outlined, size: 15, color: Color(0xFF1D4FD7)),
              SizedBox(width: 6),
              Text('Continue Practicing', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1D4FD7))),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Mathematics: Trigonometry',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'You are making steady progress. Keep going to earn more rewards!',
            style: TextStyle(fontSize: 11.5, color: Color(0xFF5A6178), height: 1.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: mastery,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFD8E2FF),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF1D4FD7)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text('${(mastery * 100).round()}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1D4FD7))),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpcomingEventCard extends StatelessWidget {
  const _UpcomingEventCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2A1A52), Color(0xFF160F33)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.schedule, size: 15, color: Color(0xFFC9B8FF)),
              SizedBox(width: 6),
              Text('Upcoming Events', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFC9B8FF))),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFFFFB547), borderRadius: BorderRadius.circular(5)),
                      child: const Text('Arena Event', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF3A2100))),
                    ),
                    const SizedBox(height: 6),
                    const Text('Physics Blitz', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(8)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Starts in', style: TextStyle(fontSize: 10, color: Colors.white70)),
                    Text('24:15:39', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String text;
  const _NotificationItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF2F6FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(color: Color(0xFFE3ECFF), shape: BoxShape.circle),
            child: const Icon(Icons.mail_outline, size: 15, color: Color(0xFF1D4FD7)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
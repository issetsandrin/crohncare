import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../stores/dashboard_store.dart';
import 'alarmes_page.dart';
import 'remedios_page.dart';
import 'consultas_page.dart';
import 'ajustes_page.dart';

class DashboardPage extends StatefulWidget {
  final DashboardStore store = DashboardStore();

  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildTabs(),
          const SizedBox(height: 8),
          Expanded(
            child: Builder(
              builder: (context) {
                switch (_selectedTab) {
                  case 0:
                    return AlarmesPage(store: widget.store);
                  case 1:
                    return RemediosPage();
                  case 2:
                    return ConsultasPage();
                  case 3:
                    return AjustesPage();
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0052D4), Color(0xFF4364F7), Color(0xFF6FB1FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color.fromARGB(59, 255, 255, 255),
                child: Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Olá, Vitor Sandrin!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Cuidando da sua saúde',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildProximoMedicamento(),
            ],
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Icon(Icons.notifications, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildProximoMedicamento() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Próximo medicamento',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                'Azatioprina',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '2 comprimidos ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.alarm, color: Colors.white, size: 28),
              const Text(
                '06:00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TabItem(
            icon: Icons.alarm,
            label: 'Alarmes',
            selected: _selectedTab == 0,
            onTap: () => setState(() => _selectedTab = 0),
          ),
          TabItem(
            icon: Icons.medication,
            label: 'Remédios',
            selected: _selectedTab == 1,
            onTap: () => setState(() => _selectedTab = 1),
          ),
          TabItem(
            icon: Icons.calendar_today,
            label: 'Consultas',
            selected: _selectedTab == 2,
            onTap: () => setState(() => _selectedTab = 2),
          ),
          TabItem(
            icon: Icons.settings,
            label: 'Ajustes',
            selected: _selectedTab == 3,
            onTap: () => setState(() => _selectedTab = 3),
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const TabItem({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.transparent,
        onTap: () {
          HapticFeedback.lightImpact();
          if (onTap != null) onTap!();
        },
        child: Container(
          decoration: selected
              ? BoxDecoration(
                  color: Colors.white.withOpacity(0.22), // mais visível
                  borderRadius: BorderRadius.circular(16), // mais arredondado
                )
              : null,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ), // mais espaço
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? const Color(0xFF0052D4) : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: selected ? const Color(0xFF0052D4) : Colors.grey,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

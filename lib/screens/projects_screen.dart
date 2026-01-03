import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String type;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Chip(
          label: Text(type, style: const TextStyle(fontSize: 10, color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onTap: onTap,
      ),
    );
  }
}

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedFilter = 'الكل';
  final List<String> _filters = ['الكل', 'Web', 'Mobile', 'AI', 'Design'];

  final List<Map<String, String>> projects = const [
    {
      "title": "KIT Space Application (Flutter)",
      "description": "The official mobile application for the team, combining services, a store, and a loyalty system.",
      "type": "Mobile"
    },
    {
      "title": "Content Management System (CMS)",
      "description": "An integrated web system for managing the team's courses, projects, and products.",
      "type": "Web"
    },
    {
      "title": "Smart Assistant Chatbot",
      "description": "A conversational bot built on Large Language Models to answer user inquiries.",
      "type": "AI"
    },
    {
      "title": "New Visual Identity Design",
      "description": "Comprehensive development of the team's visual identity, including logos, colors, and fonts.",
      "type": "Design"
    }
  ];

  List<Map<String, String>> get _filteredProjects {
    if (_selectedFilter == 'الكل') {
      return projects;
    }
    return projects.where((p) => p['type'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // لجعل العنوان يبدأ من اليسار/اليمين حسب اللغة
        children: [
          // --- عنوان الصفحة الجديد ---
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            child: Text(
              'Projects',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor, // نفس لون الثيم الأساسي
              ),
            ),
          ),

          // شريط التصفية (Filters)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = filter == _selectedFilter;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      selectedColor: Theme.of(context).primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // قائمة المشاريع
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                final project = _filteredProjects[index];
                return ProjectCard(
                  title: project['title']!,
                  description: project['description']!,
                  type: project['type']!,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('عرض تفاصيل: ${project['title']}')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/provider/news_provider.dart';

import 'content.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getNews = ref.watch(newsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Fetch News"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.alert_12_regular),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.search_12_regular),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breakinig news and show more section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breaking news",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Show more"),
                ],
              ),
              const Gap(12),
              //Card news section
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage("assets/openai.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "TechCrunch",
                          style: TextStyle(color: Colors.yellow),
                        ),
                        Text(
                          "Yep, 'Learning Man' is becoming a thing",
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(6),
                        const Text(
                          'Author: Kyle Wiggers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(12),
              //Recommended Dashboard
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended for you",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Show more"),
                ],
              ),

              const Gap(14),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(newsProvider);
                },
                child: Text("Refresh"),
              ),

              getNews.when(data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentPage(
                              title: data[index].title!,
                              description: data[index].description!,
                              content: data[index].content!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    data[index].urlToImage!,
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      data[index].title!,
                                      maxLines: 2,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data[index].description!,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade600,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }, error: (error, stackTrace) {
                return const Center(
                  child: Text("I encountered an error "),
                );
              }, loading: () {
                return const CircularProgressIndicator();
              })

              //Fetch Data Section
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_12_regular),
            label: 'Home',
            activeIcon: Icon(FluentIcons.home_12_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.communication_16_regular),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.bookmark_16_regular),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.person_12_regular),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

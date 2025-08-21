import 'package:flutter/material.dart';

void main() {
  runApp(StudentApp());
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Manager",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    StudentDashboard(),
    CourseDashboard(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////
///  QUESTION 1: STUDENT INFO MANAGER
//////////////////////////////////////////////////
class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int studentCount = 0;
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Dashboard")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Welcome Dashboard
            Text("Name: GLoria Badu Korkor\nCourse: Mobile Dev\nUniversity: UG",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 16),

            // Snackbar button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Hello, Augustine! Welcome to the Student Info Manager.")),
                );
              },
              child: Text("Show Alert"),
            ),

            Divider(),

            // Student Counter
            Text("Students Enrolled: $studentCount",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () => setState(() => studentCount--), icon: Icon(Icons.remove)),
                IconButton(onPressed: () => setState(() => studentCount++), icon: Icon(Icons.add)),
              ],
            ),

            Divider(),

            // Login Form
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (!emailCtrl.text.contains("@")) {
                    errorMsg = "Invalid email";
                  } else if (passCtrl.text.length < 6) {
                    errorMsg = "Password must be at least 6 chars";
                  } else {
                    errorMsg = "Login Successful 🎉";
                  }
                });
              },
              child: Text("Login"),
            ),
            Text(errorMsg, style: TextStyle(color: Colors.red)),

            Divider(),

            // Profile Picture
            Image.network(
              "https://picsum.photos/200",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
///  QUESTION 2: COURSE DASHBOARD
//////////////////////////////////////////////////
class CourseDashboard extends StatefulWidget {
  @override
  _CourseDashboardState createState() => _CourseDashboardState();
}

class _CourseDashboardState extends State<CourseDashboard> {
  String selectedCategory = "Science";
  final List<String> categories = ["Science", "Math", "Technology", "Arts", "Business"];
  final List<Map<String, String>> courses = [
    {"name": "Mobile Dev", "instructor": "Dr. Smith"},
    {"name": "Information Security", "instructor": "Papa J"},
    {"name": "Python", "instructor": "Mr. Ayitey"},
    {"name": "Cybersecurity", "instructor": "Dr. Clark"},
    {"name": "Web Development", "instructor": "Dr. White"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Courses")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Course List
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.book),
                    title: Text(courses[index]["name"]!),
                    subtitle: Text("Instructor: ${courses[index]["instructor"]}"),
                  );
                },
              ),
            ),

            // Dropdown
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (val) => setState(() => selectedCategory = val!),
              items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
            ),
            Text("Selected: $selectedCategory"),

            SizedBox(height: 20),

            // Animated Button
            GestureDetector(
              onTapDown: (_) => setState(() {}),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                child: Text("Enroll in a Course", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
///  PROFILE PAGE
//////////////////////////////////////////////////
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Exit App"),
                    content: Text("Are you sure you want to exit?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: Text("No")),
                      TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Yes")),
                    ],
                  ),
                );
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}

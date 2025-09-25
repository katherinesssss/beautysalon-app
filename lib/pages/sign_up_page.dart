import 'package:beautysalon/components/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:beautysalon/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _snackBarShown = false;
  bool _obscurePassword = true; 

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _handleSignUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Валидация полей
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError('Please fill the gaps', const Color.fromARGB(255, 52, 106, 113));
      return;
    }

    if (!_isValidEmail(email)) {
      _showError('Input correct email', const Color.fromARGB(255, 10, 9, 8));
      return;
    }

    if (password.length < 6) {
      _showError('Password must consist of 6 chars', Colors.orange);
      return;
    }

    if (password != confirmPassword) {
      _showError('Password do not match!', const Color.fromARGB(255, 16, 15, 14));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final success = await userProvider.signUp(email, password);

      if (!mounted) return;
      
      if (success) {
        Navigator.pushNamed(context, '/home');
      } else if (!_snackBarShown) {
        _showError('Users with this email already exists', const Color.fromARGB(255, 4, 3, 3));
      }
    } catch (e) {
      if (mounted && !_snackBarShown) {
        _showError('Error of registration: ${e.toString()}', Colors.red[800]!);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message, Color color) {
    setState(() => _snackBarShown = true);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      ).closed.then((_) {
        if (mounted) setState(() => _snackBarShown = false);
      });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.indigo, Colors.deepPurple, Colors.purple.shade200]
                : [Colors.lightBlueAccent, Colors.cyan, Colors.blueAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'lib/assets/lotos.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 10),
              Text(
                "CREATE YOUR ACCOUNT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Delius-Regular',
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              // Email field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Email",
                    suffixIcon: const Icon(Icons.account_circle_outlined, color: Colors.black12),
                    fillColor: Colors.grey[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.white10 : Colors.black12,
                        width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              // Password field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black26,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.white10 : Colors.black12,
                        width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              // Confirm Password field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Confirm Password',
                    suffixIcon: const Icon(Icons.key, color: Colors.black12),
                    fillColor: Colors.grey[200],
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.white10 : Colors.black12,
                        width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Sign up button
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(130, 50),
                    backgroundColor: Colors.indigo.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white),
                        )
                      : Text(
                          'Sign up',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontFamily: 'Delius-Regular',
                            fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign in link
              TextButton(
                onPressed: _isLoading ? null : () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account?',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                          fontSize: 14,
                          fontFamily: 'Delius-Regular'),
                      ),
                      TextSpan(
                        text: ' Sign in!',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.blue[700],
                          fontSize: 14,
                          fontFamily: 'Delius-Regular',
                          fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
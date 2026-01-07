import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skyboost/views/auth/login_screen.dart';
import 'package:skyboost/views/auth/register_screen.dart';
import 'package:skyboost/views/home/home_screen.dart';
import 'package:skyboost/views/services/facebook_services_screen.dart';
import 'package:skyboost/views/services/youtube_services_screen.dart';
import 'package:skyboost/views/services/order_screen.dart';
import 'package:skyboost/views/wallet/deposit_screen.dart';
import 'package:skyboost/views/wallet/transactions_screen.dart';
import 'package:skyboost/views/profile/profile_screen.dart';
import 'package:skyboost/views/profile/referral_screen.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/home',
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/services/facebook',
        name: 'facebook-services',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const FacebookServicesScreen(),
        ),
      ),
      GoRoute(
        path: '/services/youtube',
        name: 'youtube-services',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const YouTubeServicesScreen(),
        ),
      ),
      GoRoute(
        path: '/services/order/:serviceId',
        name: 'order',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: OrderScreen(
            serviceId: state.params['serviceId']!,
          ),
        ),
      ),
      GoRoute(
        path: '/deposit',
        name: 'deposit',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const DepositScreen(),
        ),
      ),
      GoRoute(
        path: '/transactions',
        name: 'transactions',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TransactionsScreen(),
        ),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: '/referral',
        name: 'referral',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ReferralScreen(),
        ),
      ),
    ],
    redirect: (context, state) {
      // Add authentication logic here
      return null;
    },
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Page non trouvée',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Retour à l\'accueil'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
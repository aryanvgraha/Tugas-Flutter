import 'package:flutter/material.dart';

import '../services/auth_state.dart';
import '../widgets/auth_widgets.dart';
import 'main_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  bool _agree = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _showSoon(String what) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$what segera hadir')));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Setujui Syarat & Ketentuan terlebih dahulu'),
          ),
        );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    AuthState.instance.login(
      email: _emailController.text.trim(),
      name: _nameController.text,
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Akun berhasil dibuat')));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainNavigation()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return AuthLayout(
      title: 'Buat Akun Baru',
      subtitle: 'Daftar untuk mulai menggunakan Unigal Apps',
      showBack: true,
      card: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Data diri',
              style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Masukkan nama lengkap'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nimController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'NIM',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              validator: (val) {
                final v = val?.trim() ?? '';
                if (v.isEmpty) return 'Masukkan NIM';
                if (!RegExp(r'^\d+$').hasMatch(v)) return 'NIM hanya angka';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (val) {
                final v = val?.trim() ?? '';
                if (v.isEmpty) return 'Masukkan email';
                if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)) {
                  return 'Format email tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscure,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) return 'Masukkan kata sandi';
                if (val.length < 6) return 'Minimal 6 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmController,
              obscureText: _obscure,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Konfirmasi Kata Sandi',
                prefixIcon: Icon(Icons.lock_reset_outlined),
              ),
              validator: (val) => val != _passwordController.text
                  ? 'Kata sandi tidak sama'
                  : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: Checkbox(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    'Saya menyetujui Syarat & Ketentuan',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: scheme.onPrimary,
                      ),
                    )
                  : const Text('Daftar'),
            ),
            const SizedBox(height: 20),
            const OrDivider(text: 'atau daftar dengan'),
            const SizedBox(height: 16),
            SocialButtons(onTap: _showSoon),
          ],
        ),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sudah punya akun?',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          TextButton(
            onPressed: _loading ? null : () => Navigator.pop(context),
            child: const Text(
              'Masuk',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

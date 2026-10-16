import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: FormPage()));
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _controller = TextEditingController();
  bool _agree = false; // Checkbox күйі
  bool _dark = false; // Switch күйі
  String _message = '';

  @override
  void dispose() {
    _controller.dispose(); // controller-ді міндетті түрде жабу керек
    super.dispose();
  }

  void _submit() {
    setState(() {
      _message = 'Сәлем, ${_controller.text.trim()}!';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Батырма тек аты жазылып, келісім белгіленгенде қосылады
    final canSubmit = _agree && _controller.text.trim().isNotEmpty;

    return Theme(
      data: _dark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Тіркелу')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                onChanged: (_) => setState(() {}), // әр әріпте экранды жаңарту
                decoration: const InputDecoration(
                  labelText: 'Атыңыз',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _agree,
                onChanged: (value) {
                  setState(() {
                    _agree = value ?? false;
                  });
                },
                title: const Text('Шарттармен келісемін'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SwitchListTile(
                value: _dark,
                onChanged: (value) {
                  setState(() {
                    _dark = value;
                  });
                },
                title: const Text('Қараңғы режим'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: canSubmit
                      ? _submit
                      : null, // null болса өшіп тұрады
                  child: const Text('Жіберу'),
                ),
              ),
              const SizedBox(height: 24),
              Text(_message, style: const TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

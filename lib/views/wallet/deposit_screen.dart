import 'package:flutter/material.dart';
import 'package:skyboost/core/constants/colors.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  String _selectedMethod = 'mobile_money';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'mobile_money',
      'name': 'Mobile Money',
      'icon': Icons.phone_android,
      'description': 'MTN Mobile Money, Moov Money, etc.',
      'color': Colors.green,
    },
    {
      'id': 'bank_transfer',
      'name': 'Virement Bancaire',
      'icon': Icons.account_balance,
      'description': 'Transfert bancaire local',
      'color': Colors.blue,
    },
    {
      'id': 'crypto',
      'name': 'Cryptomonnaie',
      'icon': Icons.currency_bitcoin,
      'description': 'Bitcoin, USDT, etc.',
      'color': Colors.orange,
    },
    {
      'id': 'card',
      'name': 'Carte Bancaire',
      'icon': Icons.credit_card,
      'description': 'Visa, Mastercard',
      'color': Colors.purple,
    },
  ];

  Future<void> _processDeposit() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer un montant'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le montant doit être supérieur à 0'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    // TODO: Implement deposit processing
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dépôt initié'),
        content: Text(
          'Votre dépôt de $amount XOF a été initié avec succès.\n'
          'Suivez les instructions de paiement qui vont apparaître.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 480 ? 
            (MediaQuery.of(context).size.width - 480) / 2 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: MediaQuery.of(context).size.width > 480 ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SkyBoost',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Dépôt de fonds',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.wallet,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Recharger votre compte',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Choisissez un montant et une méthode de paiement',
                          style: TextStyle(
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Amount Input
                        TextFormField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            labelText: 'Montant (FCFA)',
                            prefixIcon: Icon(Icons.money),
                            hintText: 'Entrez le montant',
                            border: OutlineInputBorder(),
                            suffixText: 'FCFA',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Quick Amount Buttons
                        const Text(
                          'Montants rapides:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [1000, 2000, 5000, 10000, 20000, 50000].map((amount) {
                            return ActionChip(
                              label: Text('$amount FCFA'),
                              onPressed: () {
                                _amountController.text = amount.toString();
                              },
                              backgroundColor: AppColors.primary.withOpacity(0.1),
                            );
                          }).toList(),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Payment Methods
                        const Text(
                          'Méthode de paiement:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        Column(
                          children: _paymentMethods.map((method) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: method['color'].withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    method['icon'],
                                    color: method['color'],
                                  ),
                                ),
                                title: Text(method['name']),
                                subtitle: Text(method['description']),
                                trailing: Radio<String>(
                                  value: method['id'],
                                  groupValue: _selectedMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMethod = value!;
                                    });
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: _selectedMethod == method['id']
                                        ? AppColors.primary
                                        : Colors.grey.shade300,
                                    width: _selectedMethod == method['id'] ? 2 : 1,
                                  ),
                                ),
                                tileColor: _selectedMethod == method['id']
                                    ? AppColors.primary.withOpacity(0.05)
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Submit Button
                        ElevatedButton(
                          onPressed: _isLoading ? null : _processDeposit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.payment, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Procéder au paiement',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Information
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.light,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ℹ️ Informations importantes:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '• Les dépôts sont traités sous 1 à 15 minutes\n'
                                '• Contactez le support en cas de problème\n'
                                '• Montant minimum: 1 000 FCFA\n'
                                '• Aucune commission n\'est appliquée',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
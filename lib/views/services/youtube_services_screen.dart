import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyboost/core/providers/services_provider.dart';
import 'package:skyboost/core/constants/colors.dart';
import 'package:skyboost/models/service_model.dart';

class YouTubeServicesScreen extends StatefulWidget {
  const YouTubeServicesScreen({super.key});

  @override
  State<YouTubeServicesScreen> createState() => _YouTubeServicesScreenState();
}

class _YouTubeServicesScreenState extends State<YouTubeServicesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _linkController = TextEditingController();
  final _quantityController = TextEditingController();
  Service? _selectedService;
  double _totalPrice = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    final servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    await servicesProvider.fetchYouTubeServices();
  }

  void _calculatePrice() {
    if (_selectedService == null || _quantityController.text.isEmpty) {
      setState(() => _totalPrice = 0.0);
      return;
    }
    
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    if (quantity < (_selectedService!.min)) {
      setState(() => _totalPrice = 0.0);
      return;
    }
    
    final price = _selectedService!.calculatePrice(quantity);
    setState(() => _totalPrice = price);
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner un service'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    // TODO: Implement order submission
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Commande effectuée avec succès !'),
        backgroundColor: AppColors.success,
        action: SnackBarAction(
          label: 'Voir',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/transactions');
          },
        ),
      ),
    );
    
    // Clear form
    _linkController.clear();
    _quantityController.clear();
    setState(() {
      _selectedService = null;
      _totalPrice = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final servicesProvider = Provider.of<ServicesProvider>(context);
    final services = servicesProvider.youtubeServices;
    final isLoading = servicesProvider.isLoading;

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
                                    'Boost YouTube',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Consumer<ServicesProvider>(
                                builder: (context, provider, _) {
                                  return Text(
                                    '${provider.userBalance} XOF',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  );
                                },
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
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Nouvelle Commande YouTube',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Service Selection
                              DropdownButtonFormField<Service>(
                                value: _selectedService,
                                decoration: const InputDecoration(
                                  labelText: 'Service YouTube',
                                  prefixIcon: Icon(Icons.play_circle_fill),
                                  border: OutlineInputBorder(),
                                ),
                                items: services.map((service) {
                                  return DropdownMenuItem<Service>(
                                    value: service,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            service.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            'Min: ${service.min}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (service) {
                                  setState(() {
                                    _selectedService = service;
                                    _calculatePrice();
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Veuillez sélectionner un service';
                                  }
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // YouTube Link
                              TextFormField(
                                controller: _linkController,
                                decoration: const InputDecoration(
                                  labelText: 'Lien YouTube',
                                  prefixIcon: Icon(Icons.link),
                                  hintText: 'https://youtube.com/...',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.url,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un lien YouTube';
                                  }
                                  if (!value.contains('youtube.com') && 
                                      !value.contains('youtu.be')) {
                                    return 'Veuillez entrer un lien YouTube valide';
                                  }
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Quantity
                              TextFormField(
                                controller: _quantityController,
                                decoration: const InputDecoration(
                                  labelText: 'Quantité',
                                  prefixIcon: Icon(Icons.numbers),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (_) => _calculatePrice(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer une quantité';
                                  }
                                  final quantity = int.tryParse(value) ?? 0;
                                  if (_selectedService != null && 
                                      quantity < _selectedService!.min) {
                                    return 'Quantité minimum: ${_selectedService!.min}';
                                  }
                                  if (_selectedService != null && 
                                      quantity > _selectedService!.max) {
                                    return 'Quantité maximum: ${_selectedService!.max}';
                                  }
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Price Display
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.light,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                    left: BorderSide(
                                      color: AppColors.primary,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Prix total (FCFA)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      readOnly: true,
                                      controller: TextEditingController(
                                        text: _totalPrice.toStringAsFixed(4),
                                      ),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        suffixText: 'FCFA',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // Submit Button
                              ElevatedButton(
                                onPressed: _isLoading ? null : _submitOrder,
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
                                          Icon(Icons.send, size: 20),
                                          SizedBox(width: 8),
                                          Text(
                                            'Valider la commande',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Loading indicator
                  if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 80),
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
    _linkController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
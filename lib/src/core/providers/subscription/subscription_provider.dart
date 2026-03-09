// import 'dart:async';
// import '../providers.dart';

// final subscriptionProvider =
//     NotifierProvider<SubscriptionsController, SubscriptionModel>(
//       SubscriptionsController.new,
//     );

// class SubscriptionsController extends Notifier<SubscriptionModel> {
//   final FlutterInappPurchase _inAppPurchase = FlutterInappPurchase.instance;

//   bool isServiceSupported = true;
//   bool _loading = false;

//   bool get isDesktop =>
//       Platform.isLinux || Platform.isMacOS || Platform.isWindows;

//   StreamSubscription<Purchase?>? _purchaseUpdatedSubscription;
//   StreamSubscription<PurchaseError>? _purchaseErrorSubscription;

//   BuildContext get context => RouteNavigator.context;

//   final CustomToastWidget _toast = CustomToastWidget();

//   Future<void> onInit() async {
//     await initialize();
//   }

//   Future<void> initialize() async {
//     try {
//       isServiceSupported = await _inAppPurchase.initConnection();

//       if (!isServiceSupported) {
//         log("In-app purchase service is unavailable.");
//         return;
//       }

//       _updateState(isStoreAvailable: isServiceSupported);
//       _setupPurchaseListeners();

//       final products = await getProductsDetails(
//         productIds: [PremiumPlanConstants.monthly, PremiumPlanConstants.yearly],
//       );

//       log("Subscription products retrieved: ${products.map((e) => e.price)}");
//       _updateProducts(products);

//       await checkExistingPurchases();
//     } catch (e) {
//       log("Initialization failure: $e");
//       _handleError("Unable to initialize purchase services.");
//     }
//   }

//   void _setupPurchaseListeners() {
//     _purchaseUpdatedSubscription = _inAppPurchase.purchaseUpdated.listen(
//       (purchase) {
//         if (purchase != null) {
//           log("Purchase update received for ${purchase.productId}");
//           _handlePurchaseUpdate(purchase);
//         }
//       },
//       onDone: () {
//         log("Purchase update stream closed.");
//         _purchaseUpdatedSubscription?.cancel();
//       },
//       onError: (error) {
//         log("Purchase update stream error: $error");
//         _handleError("Purchase service encountered an issue.");
//       },
//     );

//     _purchaseErrorSubscription = _inAppPurchase.purchaseErrorListener.listen((
//       error,
//     ) {
//       log("Purchase failed: ${error.message}");
//       _handlePurchaseError(error);
//     });
//   }

//   Future<void> _handlePurchaseUpdate(Purchase purchase) async {
//     log(
//       "Processing purchase ${purchase.productId} with state ${purchase.purchaseState}",
//     );

//     switch (purchase.purchaseState) {
//       case PurchaseState.Purchased:
//         await _handleSuccessfulPurchase(purchase);
//         break;

//       case PurchaseState.Pending:
//         _handlePendingPurchase(purchase);
//         break;

//       default:
//         log("Unhandled purchase state detected.");
//         _dismissLoadingIfNeeded();
//     }
//   }

//   Future<void> _handleSuccessfulPurchase(Purchase purchase) async {
//     try {
//       if (!_validatePurchase(purchase)) {
//         _handleError("Purchase verification failed.");
//         return;
//       }

//       final user = ref.read(userProvider);
//       if (user.isPremium) {
//         log("User already has premium access.");
//         await _finishTransaction(purchase);
//         _dismissLoadingIfNeeded();
//         return;
//       }

//       if (!PremiumPlanConstants.shouldContinue(purchase.id)) {
//         _handleError(
//           "There was an issue confirming your purchase. Please contact support if charged.",
//         );
//         return;
//       }

//       final purchaseDate = DateTime.fromMillisecondsSinceEpoch(
//         purchase.transactionDate.toInt(),
//       );

//       ref
//           .read(userProvider.notifier)
//           .upgradeUser(
//             planId: purchase.productId,
//             transactionId: purchase.id,
//             expiryDate: _calculateExpiry(purchase.productId, purchaseDate),
//             purchaseDate: purchaseDate,
//           );

//       log("Premium access activated for ${purchase.productId}");

//       await _finishTransaction(purchase);
//       _dismissLoadingIfNeeded();
//       RouteNavigator.replaceAll(BottomNavBar());
//       _toast.showToast(
//         message: "Congratulations! You have successfully subscribed.",
//       );
//     } catch (e) {
//       log("Purchase handling error: $e");
//       _handleError("Unable to complete purchase.");
//     }
//   }

//   void _handlePendingPurchase(Purchase purchase) {
//     log("Purchase pending for ${purchase.productId}");
//     _dismissLoadingIfNeeded();

//     _toast.showToast(
//       message:
//           "Your payment is still processing. You’ll be notified once it’s complete.",
//     );
//   }

//   void _handlePurchaseError(PurchaseError error) {
//     log("Purchase error occurred: ${error.code} - ${error.message}");
//     _dismissLoadingIfNeeded();

//     final errorCode = error.code?.toString() ?? '';
//     if (errorCode != 'E_USER_CANCELLED' && errorCode != 'USER_CANCELED') {
//       _toast.showToast(message: error.message);
//     }
//   }

//   Future<void> _finishTransaction(Purchase purchase) async {
//     try {
//       await _inAppPurchase.finishTransaction(
//         purchase: purchase,
//         isConsumable: false,
//       );
//       log("Transaction completed successfully.");
//     } catch (e) {
//       log("Transaction completion failed: $e");
//     }
//   }

//   bool _validatePurchase(PurchaseCommon purchase) {
//     if (purchase.purchaseState != PurchaseState.Purchased) {
//       log("Purchase is not finalized.");
//       return false;
//     }

//     if (purchase.productId != PremiumPlanConstants.monthly &&
//         purchase.productId != PremiumPlanConstants.yearly) {
//       log("Unrecognized subscription product.");
//       return false;
//     }

//     if (purchase.transactionDate <= 0) {
//       log("Invalid purchase timestamp.");
//       return false;
//     }

//     return true;
//   }

//   bool _isPurchaseStillValid(PurchaseCommon purchase) {
//     try {
//       final purchaseDate = DateTime.fromMillisecondsSinceEpoch(
//         purchase.transactionDate.toInt(),
//       );

//       Duration duration;
//       switch (purchase.productId) {
//         case PremiumPlanConstants.monthly:
//           duration = const Duration(days: 30);
//           break;
//         case PremiumPlanConstants.yearly:
//           duration = const Duration(days: 365);
//           break;
//         default:
//           log("Subscription type not supported.");
//           return false;
//       }

//       final expiryDate = purchaseDate
//           .add(duration)
//           .add(const Duration(hours: 1));

//       log(
//         "Subscription check — Purchased: $purchaseDate, Expires: $expiryDate",
//       );

//       return DateTime.now().isBefore(expiryDate);
//     } catch (e) {
//       log("Subscription validation error: $e");
//       return false;
//     }
//   }

//   DateTime _calculateExpiry(String planId, DateTime purchaseDate) {
//     switch (planId) {
//       case PremiumPlanConstants.monthly:
//         return DateTime(
//           purchaseDate.year,
//           purchaseDate.month + 1,
//           purchaseDate.day,
//           purchaseDate.hour,
//           purchaseDate.minute,
//           purchaseDate.second,
//         );
//       case PremiumPlanConstants.yearly:
//         return DateTime(
//           purchaseDate.year + 1,
//           purchaseDate.month,
//           purchaseDate.day,
//           purchaseDate.hour,
//           purchaseDate.minute,
//           purchaseDate.second,
//         );
//       default:
//         return purchaseDate;
//     }
//   }

//   Future<List<ProductCommon>> getProductsDetails({
//     required List<String> productIds,
//   }) async {
//     log("Loading subscription products...");
//     return _inAppPurchase.fetchProducts<ProductCommon>(
//       skus: productIds,
//       type: ProductQueryType.Subs,
//     );
//   }

//   void _updateProducts(List<ProductCommon> newproduct) {
//     final products = List<ProductCommon>.from(newproduct)
//       ..sort((a, b) => a.price!.compareTo(b.price!));

//     log("Products ordered by price.");
//     _updateState(products: products, index: 0);
//   }

//   Future<void> subscribe({required String productId}) async {
//     try {
//       _loading = true;
//       context.onLoading();

//       log("Starting subscription for $productId");

//       await _inAppPurchase.requestPurchaseWithBuilder(
//         build: (builder) {
//           builder.ios.sku = productId;
//           builder.android.skus = [productId];
//           builder.type = ProductQueryType.Subs;
//         },
//       );
//     } catch (e) {
//       log("Subscription request failed: $e");
//       _handleError("Unable to start subscription.");
//     }
//   }

//   Future<void> restorePurchase() async {
//     try {
//       _loading = true;
//       context.onLoading();

//       log("Attempting to restore previous purchases.");

//       await _inAppPurchase.restorePurchases();

//       final purchases = await _inAppPurchase.getAvailablePurchases(
//         alsoPublishToEventListenerIOS: false,
//         onlyIncludeActiveItemsIOS: true,
//       );

//       log("Restore check found ${purchases.length} purchases.");

//       bool restored = false;

//       for (final purchase in purchases) {
//         if (_isPurchaseStillValid(purchase)) {
//           await _deliverContent(purchase);
//           restored = true;
//           break;
//         }
//       }

//       _dismissLoadingIfNeeded();

//       _toast.showToast(
//         message: restored
//             ? "Your subscription has been restored."
//             : "No active subscriptions found.",
//       );
//     } catch (e) {
//       log("Restore process failed: $e");
//       _handleError("Unable to restore purchases.");
//     }
//   }

//   Future<void> _deliverContent(PurchaseCommon purchase) async {
//     final purchaseDate = DateTime.fromMillisecondsSinceEpoch(
//       purchase.transactionDate.toInt(),
//     );

//     ref
//         .read(userProvider.notifier)
//         .upgradeUser(
//           planId: purchase.productId,
//           transactionId: purchase.id,
//           expiryDate: _calculateExpiry(purchase.productId, purchaseDate),
//           purchaseDate: purchaseDate,
//         );

//     log("Subscription access restored.");
//   }

//   Future<void> checkExistingPurchases() async {
//     try {
//       log("Checking for active subscriptions.");

//       final purchases = await _inAppPurchase.getAvailablePurchases(
//         alsoPublishToEventListenerIOS: false,
//         onlyIncludeActiveItemsIOS: true,
//       );

//       Purchase? activePurchase;
//       for (final purchase in purchases) {
//         if (_isPurchaseStillValid(purchase)) {
//           activePurchase = purchase;
//           break;
//         }
//       }

//       final user = ref.read(userProvider);

//       if (activePurchase != null) {
//         final purchaseDate = DateTime.fromMillisecondsSinceEpoch(
//           activePurchase.transactionDate.toInt(),
//         );

//         ref
//             .read(userProvider.notifier)
//             .upgradeUser(
//               planId: activePurchase.productId,
//               transactionId: activePurchase.id,
//               expiryDate: _calculateExpiry(
//                 activePurchase.productId,
//                 purchaseDate,
//               ),
//               purchaseDate: purchaseDate,
//             );

//         log("Active subscription detected.");
//       } else if (user.isPremium) {
//         ref.read(userProvider.notifier).downgradeUser();
//         log("Premium access removed due to expiration.");
//       }
//     } catch (e) {
//       log("Subscription check failed: $e");
//     }
//   }

//   void _updateState({
//     bool? isStoreAvailable,
//     List<ProductCommon>? products,
//     int? index,
//   }) {
//     state = state.copyWith(
//       isStoreAvailable: isStoreAvailable ?? state.isStoreAvailable,
//       products: products ?? state.products,
//       index: index ?? state.index,
//     );
//   }

//   set updateIndex(int index) {
//     _updateState(index: index);
//   }

//   void _handleError(String message) {
//     _dismissLoadingIfNeeded();
//     if (_loading && context.mounted) {
//       _toast.showToast(message: message);
//     }
//   }

//   void _dismissLoadingIfNeeded() {
//     if (_loading && context.mounted) {
//       Navigator.of(context).pop();
//       _loading = false;
//     }
//   }

//   void dispose() {
//     log("Releasing subscription resources.");
//     _purchaseUpdatedSubscription?.cancel();
//     _purchaseErrorSubscription?.cancel();
//   }

//   @override
//   SubscriptionModel build() {
//     ref.onDispose(dispose);
//     return SubscriptionModel();
//   }
// }

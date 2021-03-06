import 'package:LaCoro/core/preferences/preferences.dart';
import 'package:LaCoro/presentation/adresses/my_address_bloc.dart';
import 'package:LaCoro/presentation/checkout/checkout_bloc.dart';
import 'package:LaCoro/presentation/order_detail/order_details_bloc.dart';
import 'package:LaCoro/presentation/order_history/order_history_bloc.dart';
import 'package:LaCoro/presentation/order_status/order_status_bloc.dart';
import 'package:LaCoro/presentation/past_order_detail/past_order_details_bloc.dart';
import 'package:LaCoro/presentation/register/register_bloc.dart';
import 'package:LaCoro/presentation/store_details/store_details_bloc.dart';
import 'package:LaCoro/presentation/store_list/store_list_bloc.dart';
import 'package:data/remote_datasource/api/city_api.dart';
import 'package:data/remote_datasource/api/order_api.dart';
import 'package:data/remote_datasource/api/parse/api_service.dart';
import 'package:data/remote_datasource/api/parse/api_service_impl.dart';
import 'package:data/remote_datasource/api/profile_api.dart';
import 'package:data/remote_datasource/api/store_api.dart';
import 'package:data/repositories/city_repository_impl.dart';
import 'package:data/repositories/order_repository_impl.dart';
import 'package:data/repositories/profile_repository_impl.dart';
import 'package:data/repositories/store_repository_impl.dart';
import 'package:domain/repositories/city_repository.dart';
import 'package:domain/repositories/order_repository.dart';
import 'package:domain/repositories/profile_repository.dart';
import 'package:domain/repositories/store_repository.dart';
import 'package:domain/use_cases/my_address_use_cases.dart';
import 'package:domain/use_cases/order_use_cases.dart';
import 'package:domain/use_cases/profile_use_cases.dart';
import 'package:domain/use_cases/store_use_cases.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

/// App module that defines the generic modules to be injected in the app
class AppModule {
  static Future<Injector> initialise(Injector injector) async {
    // core
    final preferences = await Preferences().init();
    injector.map<Preferences>((injector) => preferences, isSingleton: true);
    // Api
    injector.map<ApiService>((injector) => ApiServiceImpl(), isSingleton: true);
    injector.map<StoreApi>((injector) => StoreApi(injector.get()));
    injector.map<CityApi>((injector) => CityApi(injector.get()));
    injector.map<ProfileApi>((injector) => ProfileApi(injector.get()));
    injector.map<OrderApi>((injector) => OrderApi(injector.get()));
    // Repository
    injector.map<StoreRepository>((injector) => StoreRepositoryImpl(injector.get()));
    injector.map<CityRepository>((injector) => CityRepositoryImpl(injector.get()));
    injector.map<ProfileRepository>((injector) => ProfileRepositoryImpl(injector.get()));
    injector.map<OrderRepository>((injector) => OrderRepositoryImpl(injector.get()));
    // Use cases
    injector.map<MyAddressUseCases>((injector) => MyAddressUseCases(injector.get()));
    injector.map<StoreUseCases>((injector) => StoreUseCases(injector.get()));
    injector.map<ProfileUseCases>((injector) => ProfileUseCases(injector.get()));
    injector.map<OrderUseCases>((injector) => OrderUseCases(injector.get()));
    // BLoC
    injector.map<MyAddressBloc>((injector) => MyAddressBloc(injector.get(), injector.get()));
    injector.map<StoreListBloc>((injector) => StoreListBloc(injector.get(), injector.get(), injector.get(), injector.get()));
    injector.map<StoreDetailsBloc>((injector) => StoreDetailsBloc(injector.get()));
    injector.map<OrderDetailsBloc>((injector) => OrderDetailsBloc(injector.get(), injector.get(), injector.get()));
    injector.map<RegisterBloc>((injector) => RegisterBloc(injector.get(), injector.get()));
    injector.map<CheckoutBloc>((injector) => CheckoutBloc(injector.get(), injector.get()));
    injector.map<OrderStatusBloc>((injector) => OrderStatusBloc(injector.get(), injector.get()));
    injector.map<OrderHistoryBloc>((injector) => OrderHistoryBloc(injector.get(), injector.get()));
    injector.map<PastOrderDetailsBloc>((injector) => PastOrderDetailsBloc(injector.get()));
    return injector;
  }
}

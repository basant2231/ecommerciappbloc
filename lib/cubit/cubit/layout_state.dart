part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class SuccessGetUserDataState extends LayoutState {}

class LoadingGetUserDataState extends LayoutState {}

class FailedGetUserDataState extends LayoutState {
  String error;
  FailedGetUserDataState({
    required this.error,
  });
}
/************************************************************** */
class ChangeBottomNavIndexState extends LayoutState {}
/******************************************************************** */
class GetBannerLoadingState  extends LayoutState{}
class GetBannerSuccessState  extends LayoutState{}
class GetBannerFailingState  extends LayoutState{}
/********************************************************************** */
class GetCategoryLoadingState  extends LayoutState{}
class GetCategorySuccessState  extends LayoutState{}
class GetCategoryFailingState  extends LayoutState{}
/********************************************************************** */
class GetProductsLoadingState  extends LayoutState{}
class GetProductsSuccessState  extends LayoutState{}
class GetProductsFailingState  extends LayoutState{}
/********************************************************************** */
class AddToCardLoadingState  extends LayoutState{}
class AddToCardSuccessState  extends LayoutState{}
class AddToCardFailingState  extends LayoutState{}
/********************************************************************* */
class FilteredProductSuccessState  extends LayoutState{}
/********************************************************************* */
class getFavouritesSuccessState  extends LayoutState{}
class getFavouritesFailedState  extends LayoutState{}
/********************************************************************* */
class SuccessAddorRemoveItemFromFavouriteState extends LayoutState{}
class FailedAddorRemoveItemFromFavouriteState extends LayoutState{}
/********************************************************************* */
class GetCartsSuccessState extends LayoutState{}
class GetCartsFailedState extends LayoutState{}
/********************************************************************* */

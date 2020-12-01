import 'dart:async';

import 'package:flutter/material.dart';

import 'bottomsheet.dart';
import 'dialog.dart';
import 'getroute.dart';
//import 'snack.dart';

// ignore: non_constant_identifier_names
final GetService Get = _Get();

///Use Get.to instead of Navigator.push, Get.off instead of Navigator.pushReplacement,
///Get.offAll instead of Navigator.pushAndRemoveUntil. For named routes just add "named"
///after them. Example: Get.toNamed, Get.offNamed, and Get.AllNamed.
///To return to the previous screen, use Get.back().
///No need to pass any context to Get, just put the name of the route inside
///the parentheses and the magic will occur.
abstract class GetService {
  GlobalKey<NavigatorState> get key;

  factory GetService() => Get;

  /// It replaces Navigator.push, but needs no context, and it doesn't have the Navigator.push
  /// routes rebuild bug present in Flutter. If for some strange reason you want the default behavior
  /// of rebuilding every app after a route, use rebuildRoutes = true as the parameter.
  Future<T> to<T>(Widget page,
      {bool rebuildRoutes = false, Transition transition = Transition.fade});

  /// It replaces Navigator.pushNamed, but needs no context, and it doesn't have the Navigator.pushNamed
  /// routes rebuild bug present in Flutter. If for some strange reason you want the default behavior
  /// of rebuilding every app after a route, use rebuildRoutes = true as the parameter.
  Future<T> toNamed<T>(String page, {arguments});

  /// It replaces Navigator.pushReplacementNamed, but needs no context.
  Future<T> offNamed<T, TO>(String page, {arguments});

  /// It replaces Navigator.popUntil, but needs no context.
  void until(String page, predicate);

  /// It replaces Navigator.pushAndRemoveUntil, but needs no context.
  Future<T> offUntil<T>(page, predicate);

  /// It replaces Navigator.pushNamedAndRemoveUntil, but needs no context.
  Future<T> offNamedUntil<T>(page, predicate);

  /// It replaces Navigator.removeRoute, but needs no context.
  void removeRoute(route);

  /// It replaces Navigator.pushNamedAndRemoveUntil, but needs no context.
  ///
  /// If no [predicate] is provided, then all routes will be popped
  Future<T> offAllNamed<T>(
    String newRouteName, {
    RoutePredicate predicate,
    arguments,
  });

  /// It replaces Navigator.pop, but needs no context.
  void back<T>({T result});

  /// It will close as many screens as you define. Times must be> 0;
  void close(int times);

  /// It replaces Navigator.pushReplacement, but needs no context, and it doesn't have the Navigator.pushReplacement
  /// routes rebuild bug present in Flutter. If for some strange reason you want the default behavior
  /// of rebuilding every app after a route, use rebuildRoutes = true as the parameter.
  ///
  /// If no [predicate] is provided, then all routes will be popped
  Future<T> off<T, TO>(Widget page,
      {bool rebuildRoutes = false,
      Transition transition = Transition.rightToLeft});

  /// It replaces Navigator.pushAndRemoveUntil, but needs no context
  ///
  /// If no [predicate] is provided, then all routes will be popped
  Future<T> offAll<T>(Widget page,
      {RoutePredicate predicate,
      bool rebuildRoutes = false,
      Transition transition = Transition.rightToLeft});

  /// Show a dialog. You can choose color and opacity of background
  Future<T> dialog<T>(
    Widget child, {
    bool barrierDismissible = true,
    //  WidgetBuilder builder,
    bool useRootNavigator = true,
  });

  Future defaultDialog(
      {Color color,
      double opacity = 0.2,
      String title = "Alert dialog",
      Widget content,
      Widget cancel,
      Widget confirm});

  Future<T> bottomSheet<T>({
    @required WidgetBuilder builder,
    Color backgroundColor,
    double elevation,
    ShapeBorder shape,
    Clip clipBehavior,
    Color barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
  });

//  GetBar snackbar(title, message,
//      {Color colorText,
//      Duration duration,
//      SnackPosition snackPosition,
//      Widget titleText,
//      Widget messageText,
//      Widget icon,
//      bool shouldIconPulse,
//      double maxWidth,
//      EdgeInsets margin,
//      EdgeInsets padding,
//      double borderRadius,
//      Color borderColor,
//      double borderWidth,
//      Color backgroundColor,
//      Color leftBarIndicatorColor,
//      List<BoxShadow> boxShadows,
//      Gradient backgroundGradient,
//      FlatButton mainButton,
//      OnTap onTap,
//      bool isDismissible,
//      bool showProgressIndicator,
//      SnackDismissDirection dismissDirection,
//      AnimationController progressIndicatorController,
//      Color progressIndicatorBackgroundColor,
//      Animation<Color> progressIndicatorValueColor,
//      SnackStyle snackStyle,
//      Curve forwardAnimationCurve,
//      Curve reverseAnimationCurve,
//      Duration animationDuration,
//      double barBlur,
//      double overlayBlur,
//      Color overlayColor,
//      Form userInputForm});
}

class _Get implements GetService {
  final GlobalKey<NavigatorState> key = new GlobalKey<NavigatorState>();

  ///Use Get.to instead of Navigator.push, Get.off instead of Navigator.pushReplacement,
  ///Get.offAll instead of Navigator.pushAndRemoveUntil. For named routes just add "named"
  ///after them. Example: Get.toNamed, Get.offNamed, and Get.AllNamed.
  ///To return to the previous screen, use Get.back().
  ///No need to pass any context to Get, just put the name of the route inside
  ///the parentheses and the magic will occur.
  _Get();

  /// It replaces Navigator.push, but needs no context, and it doesn't have the Navigator.push
  /// routes rebuild bug present in Flutter. If for some strange reason you want the default behavior
  /// of rebuilding every app after a route, use rebuildRoutes = true as the parameter.
  Future<T> to<T>(Widget page,
      {bool rebuildRoutes = false, Transition transition = Transition.fade}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return key.currentState.push<T>(
        GetRoute(opaque: rebuildRoutes, page: page, transition: transition));
  }

  /// It replaces Navigator.pushNamed, but needs no context, and it doesn't have the Navigator.pushNamed
  /// routes rebuild bug present in Flutter. If for some strange reason you want the default behavior
  /// of rebuilding every app after a route, use rebuildRoutes = true as the parameter.
  Future<T> toNamed<T>(String page, {arguments}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return key.currentState.pushNamed<T>(page, arguments: arguments);
  }

  /// It replaces Navigator.pushReplacementNamed, but needs no context.
  Future<T> offNamed<T, TO>(String page, {arguments}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return key.currentState
        .pushReplacementNamed<T, TO>(page, arguments: arguments);
  }

  /// It replaces Navigator.popUntil, but needs no context.
  void until(String page, predicate) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return key.currentState.popUntil(predicate);
  }

  /// It replaces Navigator.pushAndRemoveUntil, but needs no context.
  Future<T> offUntil<T>(page, predicate) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return key.currentState.pushAndRemoveUntil<T>(page, predicate);
  }

  /// It replaces Navigator.pushNamedAndRemoveUntil, but needs no context.
  Future<T> offNamedUntil<T>(page, predicate) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return key.currentState.pushNamedAndRemoveUntil<T>(page, predicate);
  }

  /// It replaces Navigator.removeRoute, but needs no context.
  void removeRoute(route) {
    return key.currentState.removeRoute(route);
  }

  /// It replaces Navigator.pushNamedAndRemoveUntil, but needs no context.
  ///
  /// If no [predicate] is provided, then all routes will be popped
  Future<T> offAllNamed<T>(
    String newRouteName, {
    RoutePredicate predicate,
    arguments,
  }) {
    predicate ??= (route) => false;
    return key.currentState.pushNamedAndRemoveUntil<T>(newRouteName, predicate,
        arguments: arguments);
  }

  /// It replaces Navigator.pop, but needs no context.
  void back<T>({T result}) {
    key.currentState.pop<T>(result);
  }

  /// It will close as many screens as you define. Times must be> 0;
  void close(int times) {
    if ((times == null) || (times < 1)) {
      times = 1;
    }
    int count = 0;
    key.currentState.popUntil((route) {
      return count++ == times;
    });
  }

  /// It replaces Navigator.pushReplacement, but needs no context, and it doesn't have the Navigator.pushReplacement
  /// routes rebuild bug present in Flutter. If for some strange reason you want the default behavior
  /// of rebuilding every app after a route, use rebuildRoutes = true as the parameter.
  ///
  /// If no [predicate] is provided, then all routes will be popped
  Future<T> off<T, TO>(Widget page,
      {bool rebuildRoutes = false,
      Transition transition = Transition.rightToLeft}) {
    return key.currentState.pushReplacement<T, TO>(
        GetRoute<T>(opaque: rebuildRoutes, page: page, transition: transition));
  }

  /// It replaces Navigator.pushAndRemoveUntil, but needs no context
  ///
  /// If no [predicate] is provided, then all routes will be popped
  Future<T> offAll<T>(Widget page,
      {RoutePredicate predicate,
      bool rebuildRoutes = false,
      Transition transition = Transition.rightToLeft}) {
    predicate ??= (route) => true;
    return key.currentState.pushAndRemoveUntil<T>(
        GetRoute<T>(opaque: rebuildRoutes, page: page, transition: transition),
        predicate);
  }

  /// Show a dialog. You can choose color and opacity of background
  Future<T> dialog<T>(
    Widget child, {
    bool barrierDismissible = true,
    //  WidgetBuilder builder,
    bool useRootNavigator = true,
  }) {
    assert(child != null);
    assert(useRootNavigator != null);
    final ThemeData theme = Theme.of(key.currentContext);
    return getShowGeneralDialog(
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = child; // ?? Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel:
          MaterialLocalizations.of(key.currentContext).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 150),
      // transitionBuilder: _buildMaterialDialogTransitions,
      useRootNavigator: useRootNavigator,
    );
  }

  Future defaultDialog(
      {Color color,
      double opacity = 0.2,
      String title = "Alert dialog",
      Widget content,
      Widget cancel,
      Widget confirm}) {
    final child = DefaultDialogGet(
      color: color,
      opacity: opacity,
      title: title,
      content: content,
      cancel: cancel,
      confirm: confirm,
    );

    return dialog<dynamic>(child);
  }

  Future<T> bottomSheet<T>({
    @required WidgetBuilder builder,
    Color backgroundColor,
    double elevation,
    ShapeBorder shape,
    Clip clipBehavior,
    Color barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    assert(builder != null);
    assert(isScrollControlled != null);
    assert(useRootNavigator != null);
    assert(isDismissible != null);
    assert(enableDrag != null);

    return key.currentState.push<T>(GetModalBottomSheetRoute<T>(
      builder: builder,
      theme: Theme.of(key.currentContext),
      isScrollControlled: isScrollControlled,
      barrierLabel:
          MaterialLocalizations.of(key.currentContext).modalBarrierDismissLabel,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      enableDrag: enableDrag,
    ));
  }

//  GetBar snackbar(title, message,
//      {Color colorText,
//      Duration duration,
//      SnackPosition snackPosition,
//      Widget titleText,
//      Widget messageText,
//      Widget icon,
//      bool shouldIconPulse,
//      double maxWidth,
//      EdgeInsets margin,
//      EdgeInsets padding,
//      double borderRadius,
//      Color borderColor,
//      double borderWidth,
//      Color backgroundColor,
//      Color leftBarIndicatorColor,
//      List<BoxShadow> boxShadows,
//      Gradient backgroundGradient,
//      FlatButton mainButton,
//      OnTap onTap,
//      bool isDismissible,
//      bool showProgressIndicator,
//      SnackDismissDirection dismissDirection,
//      AnimationController progressIndicatorController,
//      Color progressIndicatorBackgroundColor,
//      Animation<Color> progressIndicatorValueColor,
//      SnackStyle snackStyle,
//      Curve forwardAnimationCurve,
//      Curve reverseAnimationCurve,
//      Duration animationDuration,
//      double barBlur,
//      double overlayBlur,
//      Color overlayColor,
//      Form userInputForm}) {
//    //   if (key.currentState.mounted)
//    return GetBar(
//        titleText: titleText ??
//            Text(
//              title,
//              style: TextStyle(
//                  color: colorText ?? Theme.of(Get.key.currentContext).accentColor,
//                  fontWeight: FontWeight.w800,
//                  fontSize: 16),
//            ),
//        messageText: messageText ??
//            Text(
//              message,
//              style: TextStyle(
//                  color: colorText ?? Theme.of(Get.key.currentContext).accentColor,
//                  fontWeight: FontWeight.w300,
//                  fontSize: 14),
//            ),
//        snackPosition: snackPosition ?? SnackPosition.TOP,
//        borderRadius: borderRadius ?? 15,
//        margin: margin ?? EdgeInsets.symmetric(horizontal: 10),
//        duration: duration ?? Duration(seconds: 3),
//        barBlur: barBlur ?? 7.0,
//        backgroundColor: backgroundColor ?? Colors.grey.withOpacity(0.2),
//        icon: icon,
//        shouldIconPulse: shouldIconPulse ?? true,
//        maxWidth: maxWidth,
//        padding: padding ?? EdgeInsets.all(16),
//        borderColor: borderColor,
//        borderWidth: borderWidth,
//        leftBarIndicatorColor: leftBarIndicatorColor,
//        boxShadows: boxShadows,
//        backgroundGradient: backgroundGradient,
//        mainButton: mainButton,
//        onTap: onTap,
//        isDismissible: isDismissible ?? true,
//        dismissDirection: dismissDirection ?? SnackDismissDirection.VERTICAL,
//        showProgressIndicator: showProgressIndicator ?? false,
//        progressIndicatorController: progressIndicatorController,
//        progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
//        progressIndicatorValueColor: progressIndicatorValueColor,
//        snackStyle: snackStyle ?? SnackStyle.FLOATING,
//        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeOutCirc,
//        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutCirc,
//        animationDuration: animationDuration ?? Duration(seconds: 1),
//        overlayBlur: overlayBlur ?? 0.0,
//        overlayColor: overlayColor ?? Colors.transparent,
//        userInputForm: userInputForm)
//      ..show();
//  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidcallBack successCallBack,
    AwAysVoidcallBack? everKallBack,
    ErrorVoidcallBack? errocallBack,
  }) {
    changeNotifier.addListener(() {
      if (everKallBack != null) {
        everKallBack(changeNotifier, this);
      }

      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errocallBack != null) {
          errocallBack(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro nterno');
      } else if (changeNotifier.isSuccess) {
        successCallBack(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidcallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerIstance);

typedef ErrorVoidcallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerIstance);

typedef AwAysVoidcallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerIstance);

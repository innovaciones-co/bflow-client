import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/footer_bar.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PageContainerWidget extends StatefulWidget {
  const PageContainerWidget({
    super.key,
    required this.title,
    this.child,
    this.actions,
  });

  final String title;
  final Widget? child;
  final List<Widget>? actions;

  @override
  State<PageContainerWidget> createState() => _PageContainerWidgetState();
}

class _PageContainerWidgetState extends State<PageContainerWidget> {
  Widget? footerBarWidget;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is FooterAction) {
          setState(() {
            if (state.visible) {
              footerBarWidget = FooterBarWidget(
                actions: state.actions,
                leading: state.leading,
                onCancel: state.onCancel,
                showCancelButton: state.showCancelButton,
              );
            } else {
              footerBarWidget = null;
            }
          });
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/background.png',
                  height: _getHeight(context),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: _getPadding(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        context.canPop()
                            ? IconButton(
                                onPressed: () => context.pop(),
                                icon: const Icon(Icons.back_hand_outlined),
                              )
                            : const SizedBox.shrink(),
                        Text(
                          widget.title,
                          style: context.displaySmall,
                        ),
                        const Spacer(),
                        widget.actions != null
                            ? Row(
                                children: widget.actions!,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(
                      height: context.isMobile || context.isSmallTablet
                          ? 10
                          : context.isTablet
                              ? 15
                              : 30,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: widget.child ?? const SizedBox.shrink(),
                      ),
                    )
                  ],
                ),
              ),
              footerBarWidget != null
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: footerBarWidget,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets _getPadding(BuildContext context) {
    if (context.isDesktop) {
      return const EdgeInsets.only(left: 60, right: 60, top: 30.0, bottom: 0);
    }

    if (context.isTablet) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 30.0);
    }

    return const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0);
  }

  double _getHeight(BuildContext context) {
    if (context.isDesktop) {
      return 300;
    }

    if (context.isTablet) {
      return 250;
    }

    return 200;
  }
}

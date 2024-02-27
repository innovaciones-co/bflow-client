part of 'templates_cubit.dart';

sealed class TemplatesState extends Equatable {
  const TemplatesState();

  @override
  List<Object> get props => [];
}

final class TemplatesInitial extends TemplatesState {}

final class TemplatesLoaded extends TemplatesState {
  final List<TemplateEntity> templates;
  final TemplateEntity selectedTemplate;

  TemplatesLoaded({required this.templates, TemplateEntity? selectedTemplate})
      : selectedTemplate = selectedTemplate ?? templates.first;

  @override
  List<Object> get props => [templates, selectedTemplate];

  TemplatesLoaded copyWith({
    List<TemplateEntity>? templates,
    TemplateEntity? selectedTemplate,
  }) =>
      TemplatesLoaded(
        templates: templates ?? this.templates,
        selectedTemplate: selectedTemplate ?? this.selectedTemplate,
      );
}

final class TemplatesError extends TemplatesState {
  final Failure failure;

  const TemplatesError({required this.failure});
}

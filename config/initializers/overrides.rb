DeviseController.class_eval do
  # Get message for given
  def find_message(kind, options = {})
    options[:scope] ||= translation_scope
    options[:default] = Array(options[:default]).unshift(kind.to_sym)
    options[:resource_name] = resource_name
    options = devise_i18n_options(options)
    { kind => I18n.t("#{options[:resource_name]}.#{kind}", options) }
  end
end
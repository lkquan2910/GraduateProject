class MenuPolicy
  class << self
    Permission::LIST_MODEL_NAME.values.each do |model_name|
      define_method :"show_#{model_name.underscore}?" do
        return false unless User.current.internal?
        # User.current.check_permission("#{model_name}", 'can_view')
        User.current.check_permission_index "#{model_name}"
      end
    end
  end
end

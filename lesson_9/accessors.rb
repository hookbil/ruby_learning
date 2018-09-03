module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |name|
        method_name = "@#{name}".to_sym
        history_method_name = "#{name}_history".to_sym
        history_variable_name = "@#{history_method_name}".to_sym
        define_method(name) { instance_variable_get(method_name) }
        define_method(history_method_name) { instance_variable_get(history_variable_name) }
        define_method("#{name}=".to_sym) do |value|
          history = instance_variable_get(history_variable_name)
          history ||= instance_variable_set(history_variable_name, [instance_variable_get(method_name)])
          instance_variable_set(method_name, value)
          history << value
        end
      end
    end

    def strong_attr_accessor(method, class_name)
      method_name = "@#{method}".to_sym
      define_method(method) { instance_variable_get(method_name) }
      define_method("#{method}=".to_sym) do |value|
        raise TypeError, "Неверный тип класса #{class_name}" unless value.is_a?(class_name)
        instance_variable_set(method_name, value)
      end
    end
  end
end

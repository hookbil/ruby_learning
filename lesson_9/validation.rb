module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation
    def validate(object, validation_type, *args)
      @validation ||= []
      @validation << { object: "@#{object}".to_sym, validation_type: validation_type, args: args }
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue RuntimeError
      false
    end

    def validate!
      self.class.validation.each do |validation|
        object_sym = validation[:object]
        validation_type = "validate_#{validation[:validation_type]}".to_sym
        args = validation[:args]
        result =
          case validation_type
          when :validate_presence then validate_presence(object_sym)
          when :validate_format then validate_format(object_sym, args[0])
          when :validate_type then validate_type(object_sym, args[0])
          end
        raise ":#{object_sym} #{validation_type.to_s.capitalize} error" unless result
      end
      true
    end

    def validate_presence(object_sym)
      true if instance_variable_get(object_sym)
    end

    def validate_format(object_sym, regexp)
      true if instance_variable_get(object_sym) =~ regexp
    end

    def validate_type(object_sym, class_name)
      true if instance_variable_get(object_sym).is_a? class_name
    end
  end
end

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
        args = validation[:args]
        result = "validate_#{validation[:validation_type]}"
        method(result).call(object_sym, *args)
      end
      true
    end

    def validate_presence(object_sym)
      raise ":#{object_sym} validate_presence error" unless instance_variable_get(object_sym)
    end

    def validate_format(object_sym, regexp)
      raise ":#{object_sym} validate_format error" unless instance_variable_get(object_sym) =~ regexp
    end

    def validate_type(object_sym, class_name)
      raise ":#{object_sym} validate_type error" unless instance_variable_get(object_sym).is_a? class_name
    end
  end
end

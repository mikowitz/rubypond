class Object
  ##
  # Creates validated accessor methods for the object
  #
  # @param [*Symbol] attributes
  def self.attr_validate *attributes
    create_validation_framework
    attributes.each do |attribute|
      create_accessors_for(attribute)
    end
  end
  
  ##
  # Creates an empty instance variable <tt>@_validations</tt>,
  # a class accessor method <tt>self.validations</tt>,
  # and an instance method that calls each validation in turn
  #
  # @private
  def self.create_validation_framework
    class_eval <<-RUBY
      @_validations = []
      def self.validations
        @_validations
      end
      def validate
        self.class.validations.each do |validation|
          self.__send__(validation) if self.respond_to?(validation)
        end
      end
    RUBY
  end
  
  ##
  # Creates read and write methods for <tt>attribute</tt>,
  # and the write method includes a call to <tt>self.validate</tt>.
  #
  # @private
  # @param [Symbol] attribute
  def self.create_accessors_for(attribute)
    class_eval <<-RUBY
      @_validations << :validate_#{attribute}
      def #{attribute}
        @#{attribute}
      end
      def #{attribute}=(value)
        @#{attribute} = value
        self.validate
      end
    RUBY
  end
  
  class << self; protected :create_validation_framework, :create_accessors_for; end
end
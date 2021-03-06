require 'rubyonacid/factory'

module RubyOnAcid

#A Factory that "pulls" source factory values toward an attractor factory's value.
class AttractionFactory < Factory
  
  #Values from source_factory will be "pulled" toward values from this factory.
  attr_accessor :attractor_factory
  
  #Takes a hash with all keys supported by Factory, plus these keys and defaults:
  #  :attractor_factory => nil
  def initialize(options = {})
    super
    @source_factory = options[:source_factory]
    @attractor_factory = options[:attractor_factory]
  end
  
  #Get a value from the source_factories and a value from the attractor_factory.
  #The source_factories average will be adjusted to be closer to the attractor_factory value.
  #The closer the values are, the greater the adjustment.
  def get_unit(key)
    value = super
    attractor_value = @attractor_factory.get_unit(key)
    distance = attractor_value - value
    value += distance / 2.0
    value
  end

end

end

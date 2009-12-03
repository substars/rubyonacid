#This method takes any Factory and uses it to determine the length of lines to print.
def make_lines(factory)
  #Show what factory we're working with.
  puts factory.class.name
  10.times do
    #Get the length of the line.
    #The :max option scales the returned length to be between 0 and 79.
    line_length = factory.get(:length, :max => 79)
    puts "|" * line_length
  end
end

#Random factories generate a random number between 0 and 1.
require 'rubyonacid/factories/random'
make_lines RubyOnAcid::RandomFactory.new

#Loop factories loop from 0 to 1 (or 1 to 0 if the increment value is negative).
require 'rubyonacid/factories/loop'
make_lines RubyOnAcid::LoopFactory.new(0.2)
make_lines RubyOnAcid::LoopFactory.new(-0.2)

#Constant factories always return the same value,
require 'rubyonacid/factories/constant'
make_lines RubyOnAcid::ConstantFactory.new(0.5)

#This flash factory returns 0 twice, then 1 twice, then 0 twice, etc.
require 'rubyonacid/factories/flash'
make_lines RubyOnAcid::FlashFactory.new(2)

#Sine factories produce a "wave" pattern.
require 'rubyonacid/factories/sine'
make_lines RubyOnAcid::SineFactory.new(0.3)

#A RepeatFactory wraps another factory, queries it, and repeats the same value a certain number of times.
require 'rubyonacid/factories/repeat'
factory_to_repeat = RubyOnAcid::LoopFactory.new(0.3)
make_lines RubyOnAcid::RepeatFactory.new(factory_to_repeat, 2)

#A CombinationFactory combines the values of two or more other factories.
require 'rubyonacid/factories/combination'
factories_to_combine = [
  RubyOnAcid::SineFactory.new(0.1),
  RubyOnAcid::SineFactory.new(-0.2)
]
make_lines RubyOnAcid::CombinationFactory.new(:source_factories => factories_to_combine)
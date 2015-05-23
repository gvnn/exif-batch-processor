require 'ox'

class ExifWork < ::Ox::Sax
  def start_element(name); puts "start: #{name}";        end
  def end_element(name);   puts "end: #{name}";          end
  def attr(name, value);   puts "  #{name} => #{value}"; end
  def text(value);         puts "text #{value}";         end
end
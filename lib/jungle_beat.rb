require_relative './linked_list'

class JungleBeat
  attr_reader :list

  def initialize
    @list = LinkedList.new
  end

  def append(values)
    values.split(" ").each do |value|
      @list.append(value)
    end.join(" ")
  end

  def count
    @list.count
  end

  def play
    `say -r 300 -v Alex #{list.to_string}`
  end
end

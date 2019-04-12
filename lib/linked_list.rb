require_relative './node'

class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def count(current = @head)
    return 0 unless current
    return 1 + count(current.next_node)
  end

  def prepend(data)
    new_node = Node.new(data)
    new_node.next_node = @head
    @head = new_node
    data
  end

  def append(data)
    @head ? last_node.next_node = Node.new(data) : @head = Node.new(data)
    data
  end

  def insert(position, data)
    unless position == 0 || position >= count
      replace_next(find_nth_node(position, @head), data)
    else
      prepend(data) if position == 0
      append(data) if position >= count
    end
    data
  end

  def includes?(value)
    return false unless @head
    has_value?(value)
  end

  def find(position, length)
    return "" if position > count
    found_node = find_nth_node(position, @head)
    partial_string(found_node, length)
  end

  def to_string(node = @head)
    return node.data unless node.next_node
    return "#{node.data} #{to_string(node.next_node)}"
  end

  def pop
    return nil unless @head
    return pop_head unless @head.next_node
    return pop_last_node
  end

  private

  def last_node(node = @head)
    return node unless node.next_node
    last_node(node.next_node)
  end

  def find_nth_node(position, current, i = 0)
    return current if position == i
    return find_nth_node(position, current.next_node, i + 1)
  end

  def replace_next(node, data)
    new_node = Node.new(data)
    new_node.next_node = node.next_node
    node.next_node = new_node
  end

  def has_value?(value, current = @head)
    return false unless current
    return true if current.data == value
    return has_value?(value, current.next_node)
  end

  def pop_head
    data = @head.data
    @head = nil
    data
  end

  def pop_last_node
    new_end = find_nth_node(count - 2, @head, 0)
    data = new_end.next_node.data
    new_end.next_node = nil
    data
  end

  def partial_string(current, remaining)
    return current.data unless current.next_node && remaining > 1
    return "#{current.data} #{partial_string(current.next_node, remaining - 1)}"
  end
end

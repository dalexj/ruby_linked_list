class List
  include Enumerable

  def initialize
    @head = NullLink.new
  end

  def push(data)
    @head = @head.push(data)
    self
  end

  def pop
    if @head.next_link.is_a? NullLink
      data = @head.data
      @head = @head.next_link
      data
    else
      @head.pop
    end
  end

  def delete(data)
    @head = @head.delete(data)
  end

  def size
    count
  end

  def inspect
    "<List(#{map(&:inspect).join(", ")})>"
  end

  def each(&block)
    loop_through { |link| block.call(link.data) }
  end

  private

  def loop_through(&block)
    link = @head
    until link.is_a? NullLink
      block.call(link)
      link = link.next_link
    end
  end
end

class NullLink
  attr_reader :data, :pop, :next_link
  def push(data)
    Link.new(data)
  end

  def delete(*)
    self
  end
end

class Link
  attr_reader :data, :next_link
  def initialize(data)
    @data = data
    @next_link = NullLink.new
  end

  def push(data)
    @next_link = next_link.push(data)
    self
  end

  def delete(daata)
    return next_link if daata == data
    @next_link = next_link.delete(daata)
    self
  end

  def pop
    if next_link.next_link.is_a? NullLink
      daata = next_link.data
      @next_link = next_link.next_link
      daata
    else
      next_link.pop
    end
  end
end

require 'date'

Book = Struct.new(:author, :title)

class Orders
  attr_reader :book, :name, :order_date, :issue_date
  @@ord_list = []
  
  def initialize(book, name, order_date, issue_date = nil)
    @book, @name, @order_date, @issue_date = book, name, order_date, issue_date
    @@ord_list << self
  end
  
  def self.smallest_period
    @@ord_list.select{ |x| x.issue_date}.min_by{ |x| x.issue_date - x.order_date}
  end
  
  def self.not_satisfied
    @@ord_list.select{ |x| !x.issue_date}.count
  end
  
  def self.often_book(book)
    list = @@ord_list.select{ |x| x.book == book}
    list.inject(Hash.new(0)){|hash, x| hash[x.name] += 1; hash}.sort_by(&:last).reverse
  end
  
  def self.most_popular_book
   book_count.last[0]
  end
  
  def self.one_of_three
    books = book_count.reverse.first(3).map{|x|x[0]}
    hash = {}
    @@ord_list.each{|x| hash[x.name] = 0 if books.include? x.book}
    hash.count
  end
  
  private
  
  def self.book_count
    @@ord_list.inject(Hash.new(0)){|hash, x| hash[x.book] += 1; hash}.sort_by(&:last)
  end
end

a = [Book.new('Jack London', 'Martin Eden'),
     Book.new('Leo Tolstoy', 'War and Peace'),
     Book.new('Alexander Griboyedov', 'Woe from Wit'),
     Book.new('Terry Pratchett', 'The Colour of Magic')]

Orders.new(a[0], 'Ivan', Date.new(2011, 10, 5))
Orders.new(a[2], 'Jorik', Date.new(2011, 10, 5), Date.new(2011, 11, 10))
Orders.new(a[3], 'John', Date.new(2011, 9, 5), Date.new(2011, 10, 6))
Orders.new(a[2], 'John', Date.new(2011, 10, 8), Date.new(2011, 10, 10))
Orders.new(a[1], 'John', Date.new(2011, 12, 5), Date.new(2012, 10, 6))


p Orders.smallest_period
p Orders.not_satisfied
p Orders.often_book(a[2])
p Orders.most_popular_book
p '======'
p Orders.one_of_three
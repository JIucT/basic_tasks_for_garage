Address = Struct.new(:city, :street, :house, :appartment)

class Parcels
  attr_reader :address, :destination, :value
  @@ord_list = []
  
  def initialize(address, destination, value)
    @address, @destination, @value = address, destination, value
    @@ord_list << self
  end
  
  def self.parcels_to_city(city)
    @@ord_list.select{|x| x.destination.city == city}.count
  end
  
  def self.parcels_with_high_value
    @@ord_list.select{|x| x.value > 10}.count
  end
  
  def self.most_popular_address
    @@ord_list.inject(Hash.new(0)){|hash, x| hash[x.address] += 1; hash}.sort_by(&:last).last[0]
  end

end

a = [Address.new('Dnepropetrovsk', 'Kirova', 12, 34),
     Address.new('Chervni pivni', 'Utyata', 3, 12),
     Address.new('Dnepropetrovsk', 'Lenina', 2, 1)]
     
Parcels.new(a[0], a[2], 2)
Parcels.new(a[2], a[1], 2)
Parcels.new(a[2], a[1], 42)

p Parcels.parcels_to_city('Chervni pivni')
p Parcels.parcels_with_high_value
p Parcels.most_popular_address

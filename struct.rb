class Factory
  def self.new(*params, &block)
    Class.new do
      attr_accessor *params

      if block_given?
        class_eval(&block)
      end

      define_singleton_method :new do |*values|
        instance = super()        
        keys = params
        instance.instance_eval do
          @fields = Hash[keys.zip values]
          @fields.each do |key, value|
            self.class.__send__(:define_method, key) do
              @fields[key]
            end
          end
        end
        instance
      end

      def [](index)
        if index.is_a?(Integer)
          @fields.values[index]
        else
          @fields[index.to_sym]
        end
      end

      def []=(index, value)
        if index.is_a?(Integer)
          @fields.keys.each_with_index do |key, i|
            @fields[key] = value if i == index
          end
        else
          @fields[index.to_sym] = value
        end
      end
    end
  end
end


Customer = Factory.new(:name, :address, :zip)
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)

p joe.name
p joe.zip 

joe["name"] = "Luke"
joe[:zip] = "90210"

p joe.name #=> "Luke"
p joe.zip #=> "90210"


Customer2 = Factory.new(:name, :address, :zip2)
joe2 = Customer2.new("Joe Smith", "123 Maple, Anytown NC", 12345)
 p joe.class
p joe2.name 
p joe2.zip2 

# Joe Smith
# 123 Maple, Anytown NC
# 12345

p joe.name #=> "Luke"
p joe.zip #=> "90210"

Customer = Factory.new(:name, :address, :zip)
 
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)

p joe.name
p joe["name"]
p joe[:name]
p joe[1]
#"Joe Smith"


Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

p Customer.new("Dave", "123 Main").greeting
# "Hello Dave!"

s = Struct.new(:name)
a = Factory.new(:name)

class D < Factory.new(:haha)
end
class AA < Factory ; end
t = AA.new(:name)
p t.new("tt").name
x = a.new("dfdf")
p x['name']
p D.new("DD").haha
xx = a.new("dfdfxx")
p x, xx
#p s.new("dfdf")

#p a.new.ancestors

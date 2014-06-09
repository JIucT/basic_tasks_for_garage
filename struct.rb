class Factory
  def self.new(*params)
    Class.new do 
      attr_accessor *params
      def self.new(*values)        
        instance = super()
        keys = @fields_names
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

      if block_given?
        yield
      end
      @fields_names = params
    end
  end
end



Customer = Struct.new(:name, :address, :zip)
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)

joe["name"] = "Luke"
joe[:zip]   = "90210"

p joe.name   #=> "Luke"
p joe.zip    #=> "90210"


Customer = Struct.new(:name, :address, :zip)
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
joe.each {|x| puts(x) }

# Joe Smith
# 123 Maple, Anytown NC
# 12345


Customer = Struct.new(:name, :address, :zip)
 
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
 
p joe.name
p joe["name"]
p joe[:name]
p joe[0]
#"Joe Smith"


Customer = Struct.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end
p Customer.new("Dave", "123 Main").greeting
# "Hello Dave!"
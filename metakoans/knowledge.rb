class Module
  def attribute(param, value = nil, &block)
    if param.is_a? Hash
      param.each_pair { |key, value| init(key, value)}
    else
      init(param, value, &block)     
    end    
  end

private
  def init(param, value, &block)
    __send__(:attr_writer, param)
    define_method "#{param}?" do 
      !!__send__(param)
    end
    define_method param do
      if instance_variable_defined? "@#{param}"
        instance_variable_get("@#{param}")        
      else
        block ? instance_eval(&block) : value
      end        
    end
  end
end

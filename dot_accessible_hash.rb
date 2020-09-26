class DotAccessibleHash < Hash
  def method_missing(name)
    return super unless keys.find { |k| name == k }
    public_send(:[], name)
  end

  class << self
    def from(obj)
      case obj
      when Array
        obj.map { |v| from(v) }
      when Hash
        obj.each_with_object(new) do |(k, v), dah|
          dah[k.to_sym] = from(v)
        end
      else
        obj
      end
    end
  end
end

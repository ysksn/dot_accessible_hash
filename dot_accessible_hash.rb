class DotAccessibleHash < Hash
  def method_missing(name)
    public_send(:[], name) ||
    public_send(:[], name.to_s) ||
    super
  end

  class << self
    def from(obj)
      case obj
      when Array
        obj.map { |v| from(v) }
      when Hash
        obj.each_with_object(new) do |(k, v), dah|
          dah[k] = from(v)
        end
      else
        obj
      end
    end
  end
end

module Trojan
  class Spy
    DEFAULT_CALL_STRATEGY_VALUE = [nil]

    attr_reader :calls

    def initialize(obj, method_name)
      @hooked          = false
      @object          = obj
      @method_name     = method_name
      @original_method = @object.method(method_name)
      @calls           = []

      @call_strategy       = :static_return
      @call_strategy_value = DEFAULT_CALL_STRATEGY_VALUE
      @call_strategy_index = 0
    end

    def hooked?
      @hooked
    end

    def hook!
      raise "spy has already been hooked" if hooked?
      @object.define_singleton_method(@method_name, stub_method)
      @hooked = true
    end

    def unhook!
      raise "spy has not been hooked yet" unless hooked?
      @object.define_singleton_method(@method_name, @original_method)
      @hooked = false
    end

    private

    def stub_method
      this = self
      proc { |*args| this.send(:process_call, *args) }
    end

    def process_call(*args)
      record_call(args)
    end

    def record_call(args)
      @calls << args
    end
  end
end

class BasePolicy
    attr_reader :record

    def initialize(record)
        @record = record
    end

    # se ejecuta cuando el métoqo no está definido en las policies
    def method_missing(m, *args, &block)
        false
    end
end
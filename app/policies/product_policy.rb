class ProductPolicy < BasePolicy
    def update
        record.owner?
    end

    def edit
        record.owner?
    end

    def destroy
        record.owner?
    end
end
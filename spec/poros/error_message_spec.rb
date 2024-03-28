require "rails_helper"

RSpec.describe ErrorMessage do
    describe "#initialize" do
        it "exists" do
            error = ErrorMessage.new("Error", 404)

            expect(error.message).to eq("Error")
            expect(error.status_code).to eq(404)
        end
    end 
end
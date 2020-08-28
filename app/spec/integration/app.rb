# frozen_string_literal: true

RSpec.describe API do
  include Rack::Test::Methods

  let(:app) { described_class }
  let(:content) { { "CONTENT_TYPE" => "application/json" } }

  let(:transaction_json) { File.read("spec/fixtures/transaction.json") }
  let(:transactions_json) { File.read("spec/fixtures/transactions.json") }
  let(:updated_transaction_json) { File.read("spec/fixtures/updated_transaction.json") }

  let(:stripped_response_body) do
    response_body = JSON.parse(last_response.body)
    tr = response_body.first
    tr.delete("uid")
    tr
  end
  let(:last_response_body) { JSON.parse(last_response.body) }

  context "#get /" do
    it "responds with OK" do
      get "/"

      expect(last_response).to be_ok
      expect(last_response.body).to eq "OK"
    end
  end

  context "get /transactions" do
    context "returns empty array" do
      it "gets all transactions" do
        get "/transactions"

        expect(last_response).to be_ok
        expect(last_response_body).to be_an(Array)
      end
    end

    context "returns transaction array" do
      before do
        post("/transactions", transaction_json, "CONTENT_TYPE" => "application/json")
      end

      it "gets all transactions" do
        get "/transactions"

        expect(last_response).to be_ok
        expect(stripped_response_body).to eq JSON.parse(transaction_json)
      end
    end

    context "#post" do
      before do
        post("/transactions", transaction_json, "CONTENT_TYPE" => "application/json")
      end

      it "posts requests successfully" do
        expect(last_response).to be_ok
      end

      it "returns transaction as json" do
        parsed_body = JSON.parse(last_response.body)
        parsed_body.delete("uid")

        expect(parsed_body).to eq JSON.parse transaction_json
      end
    end

    context "#put" do
      before do
        post("/transactions", transaction_json, "CONTENT_TYPE" => "application/json")
        @transaction = JSON.parse last_response.body
      end

      it "updates transaction successfully" do
        uid = @transaction.fetch("uid")

        put("/transactions/#{uid}", updated_transaction_json, "CONTENT_TYPE" => "application/json")
        parsed_body = JSON.parse(last_response.body)
        parsed_body.delete("uid")

        expect(last_response).to be_ok
        expect(parsed_body).to eq JSON.parse updated_transaction_json
      end
    end

    context "#delete" do
      before do
        post("/transactions", transaction_json, "CONTENT_TYPE" => "application/json")
        @transaction = JSON.parse last_response.body
      end

      it "deletes transaction successfully" do
        uid = @transaction.fetch("uid")
        get "/transactions"

        expect(last_response).to be_ok
        expect(stripped_response_body).to eq JSON.parse(transaction_json)

        delete("/transactions/#{uid}", updated_transaction_json, "CONTENT_TYPE" => "application/json")
        expect(last_response).to be_ok
        expect(last_response.body).to be_empty
      end
    end
  end
end

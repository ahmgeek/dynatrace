# frozen_string_literal: true

RSpec.describe Transaction do
  context "#initialize" do
    let(:transaction) { build(:transaction, uid: uid) }
    let(:uid) { "123-654-abc" }
    let(:to_h) do
      {
        "uid"           => transaction.uid,
        "client_id"     => transaction.client_id,
        "sender_iban"   => transaction.sender_iban,
        "receiver_iban" => transaction.receiver_iban,
        "amount"        => transaction.amount,
        "currency"      => transaction.currency
      }
    end

    let(:new_transaction) do
      tr = build(:transaction).to_h
      tr.delete(:uid)
      tr
    end

    it "initializes Transaction correctly" do
      expect { transaction }.not_to raise_error
    end

    it "initializes correct class" do
      expect(transaction).to be_a Transaction
    end

    it "raises error with missing sender_iban" do
      attr = transaction.to_h
      attr.delete("sender_iban")

      expect { Transaction.new(transaction: attr) }.to raise_error(/sender_iban/)
    end

    it "returns correct hash" do
      expect(transaction.to_h).to eq to_h
    end

    it "updates transaction" do
      transaction.update(new_transaction)
      expect(transaction.client_id).to eq new_transaction.fetch("client_id")
      expect(transaction.sender_iban).to eq new_transaction.fetch("sender_iban")
      expect(transaction.receiver_iban).to eq new_transaction.fetch("receiver_iban")
      expect(transaction.amount).to eq new_transaction.fetch("amount")
    end
  end
end

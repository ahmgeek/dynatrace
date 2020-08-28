# frozen_string_literal: true

RSpec.describe MemoryDb do
  context "#initialize" do
    subject { described_class.new }

    let(:uid) { "8e8004b8-d91d-4d57-b7a4-605ad926fff7" }
    let(:transaction) { build(:transaction, uid: uid).to_h }
    let(:new_transaction) do
      tr = build(:transaction).to_h
      tr.delete(:uid)
      tr
    end

    it "initializes an empty store" do
      expect(subject).to be_a MemoryDb
    end

    it "saves all transactions" do
      tr = subject.save(transaction)

      expect(subject.all).to eq Array(tr)
    end

    it "saves the correct attributes" do
      result = subject.save(transaction)
      tr = subject.find(uid: result.uid)

      expect(tr.client_id).to eq transaction["client_id"]
      expect(tr.sender_iban).to eq transaction["sender_iban"]
      expect(tr.receiver_iban).to eq transaction["receiver_iban"]
      expect(tr.amount).to eq transaction["amount"]
      expect(tr.currency).to eq transaction["currency"]
    end

    it "finds specific transaction" do
      expect { subject.find(uid: "foo") }.to raise_error(/NotFound/)
    end

    it "returns all transactions" do
      3.times { subject.save(transaction) }

      expect(subject.all.size).to be 3
    end

    it "stores only unique transactions" do
      first_transaction = second_transaction = transaction
      subject.save(first_transaction)

      expect { subject.save(second_transaction) }.not_to raise_error
    end

    it "deletes transaction" do
      5.times { subject.save(transaction) }
      tr = subject.all.last

      subject.delete(uid: tr.uid)

      expect(subject.all.size).to eq 4
    end

    it "updates transaction" do
      tr = subject.save(transaction)

      expect do
        subject.update(uid: tr.uid, attr: new_transaction)
      end.not_to raise_error

      expect(subject.find(uid: tr.uid).to_h).to include("client_id"   => new_transaction["client_id"])
      expect(subject.find(uid: tr.uid).to_h).to include("sender_iban" => new_transaction["sender_iban"])
      expect(subject.find(uid: tr.uid).to_h).to include("amount"      => new_transaction["amount"])
    end

    it "raises an error on update if transaction is not found" do
      subject.save(transaction)

      expect { subject.update(uid: "i-do-not-exist", attr: transaction) }.to raise_error(/NotFound/)
    end

    it "deletes correct transaction" do
      first_tr  = subject.save(transaction)
      second_tr = subject.save(transaction)

      subject.delete(uid: first_tr.uid)

      expect(subject.all).to eq Array(second_tr)
    end
  end
end

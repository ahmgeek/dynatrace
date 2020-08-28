# frozen_string_literal: true

RSpec.describe UseCases::Transaction do
  subject { described_class.new }

  let(:transaction) { build(:transaction) }

  let(:updated_transaction) do
    build(:transaction)
  end

  let(:update_attr) do
    tr = updated_transaction.to_h
    tr.delete(:uid)
    tr
  end

  let(:transaction_attr) do
    tr = transaction.to_h
    tr.delete(:uid)
    tr
  end

  context ".saves" do
    it "saves a transaction" do
      expect(subject).to receive(:save).with(transaction_attr).and_return(transaction)
      subject.save(transaction_attr)
    end
  end

  context ".all" do
    it "gets all transactions" do
      expect(subject).to receive(:save).with(transaction_attr).and_return(transaction)
      expect(subject).to receive(:all).and_return([transaction])
      subject.save(transaction_attr)
      subject.all
    end
  end

  context ".update" do
    it "updates transaction" do
      expect(subject).to receive(:save).with(transaction_attr).and_return(transaction)
      expect(subject).to receive(:update).with(uid:  transaction.uid,
                                               attr: update_attr).and_return(updated_transaction)

      subject.save(transaction_attr)
      subject.update(uid: transaction.uid, attr: update_attr)
    end
  end

  context ".find" do
    it "finds a transaction" do
      expect(subject).to receive(:save).with(transaction_attr).and_return(transaction)
      expect(subject).to receive(:find).with(uid: transaction.uid).and_return(transaction)

      subject.save(transaction_attr)
      subject.find(uid: transaction.uid)
    end
  end

  context ".delete" do
    it "deletes a transaction" do
      expect(subject).to receive(:save).with(transaction_attr).and_return(transaction)
      expect(subject).to receive(:delete).with(uid: transaction.uid).and_return(true)

      subject.save(transaction_attr)
      subject.delete(uid: transaction.uid)
    end
  end
end

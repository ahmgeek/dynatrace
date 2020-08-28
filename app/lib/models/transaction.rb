# frozen_string_literal: true

require "securerandom"
require "json"

class Transaction
  TransactionKeyMissing = Class.new(StandardError)

  attr_reader :uid, :client_id, :sender_iban, :receiver_iban, :amount, :currency

  def initialize(transaction: {})
    err = TransactionKeyMissing

    # We try to fetch the kery from a dictionary, we raise an error if it's missing.
    self.uid            = SecureRandom.uuid
    self.client_id      = transaction.fetch("client_id") { |k| raise err.new(k.to_s) }
    self.sender_iban    = transaction.fetch("sender_iban") { |k| raise err.new(k.to_s) }
    self.receiver_iban  = transaction.fetch("receiver_iban") { |k| raise err.new(k.to_s) }
    self.amount         = transaction.fetch("amount") { |k| raise err.new(k.to_s) }
    self.currency       = transaction.fetch("currency") { |k| raise err.new(k.to_s) }
  end

  def to_h
    {
      "uid"           => uid,
      "client_id"     => client_id,
      "sender_iban"   => sender_iban,
      "receiver_iban" => receiver_iban,
      "amount"        => amount,
      "currency"      => currency
    }
  end

  def update(attrs)
    self.client_id      = attrs.fetch("client_id")
    self.sender_iban    = attrs.fetch("sender_iban")
    self.receiver_iban  = attrs.fetch("receiver_iban")
    self.amount         = attrs.fetch("amount")
    self.currency       = attrs.fetch("currency")
  end

  private

  attr_writer :uid, :client_id, :sender_iban, :receiver_iban, :amount, :currency
end

# frozen_string_literal: true

require_relative "../models/transaction"

class MemoryDb
  TransactionNotFound = Class.new(StandardError)

  def initialize
    self.store = []
  end

  def all
    store
  end

  def find(uid:)
    transaction = nil

    store.each do |tr|
      transaction = tr if tr.uid == uid
      return transaction if transaction
    end

    raise TransactionNotFound unless transaction
  end

  def save(attrs)
    transaction = Transaction.new(transaction: attrs)

    store << transaction
    transaction
  end

  def update(uid:, attr:)
    transaction = find(uid: uid)
    transaction.update(attr)
    transaction
  end

  def delete(uid:)
    transaction = find(uid: uid)
    store.delete(transaction)
  end

  private

  attr_accessor :store
end

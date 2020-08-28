# frozen_string_literal: true

require_relative "../repositories/memory_db"

module UseCases
  class Transaction
    def initialize
      self.store = MemoryDb.new
    end

    def all
      store.all.map(&:to_h)
    end

    def save(transaction)
      transaction = store.save(transaction)
      transaction.to_h
    end

    def update(uid:, attr:)
      transaction = store.update(uid: uid, attr: attr)
      transaction.to_h
    end

    def find(uid:)
      transaction = store.find(uid: uid)
      transaction.to_h
    end

    def delete(uid:)
      store.delete(uid: uid)
      true
    end

    private

    attr_accessor :store
  end
end

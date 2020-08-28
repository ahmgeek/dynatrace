# frozen_string_literal: true

require_relative "../repositories/memory_db"

module Errors
  class Handler
    def self.handle(error)
      return { error: "TransactionNotFound", status: 404 } if error.is_a?(MemoryDb::TransactionNotFound)
    end
  end
end

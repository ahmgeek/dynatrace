# frozen_string_literal: true

require "syro"
require "json"

require_relative "../lib/use_cases/transaction"
require_relative "../lib/errors/handler"

# Initializing the business logic object
TransactionService = UseCases::Transaction.new

API = Syro.new do
  # GET /
  get do
    res.write "OK"
  end

  on "transactions" do
    # GET /transactions
    get do
      res.json JSON.dump(TransactionService.all)
    end

    # POST /transactions
    post do
      attrs = JSON.parse(req.body.read)
      res.json JSON.dump(TransactionService.save(attrs))
    end

    on :uid do
      # GET /transactions/:uid
      get do
        uid = inbox[:uid]
        transaction = TransactionService.find(uid: uid)
        res.json JSON.dump(transaction)
      end

      # PUT /transactions/:uid
      put do
        uid = inbox[:uid]
        attr = JSON.parse(req.body.read)
        res.json JSON.dump(TransactionService.update(uid: uid, attr: attr))
      end

      # DELETE /transactions/:uid
      delete do
        uid = inbox[:uid]
        deleted = TransactionService.delete(uid: uid)
        res.write "" if deleted
      end
    end
  end

rescue => e
  result = Errors::Handler.handle(e)
  res.status = result[:status]
  res.json result.to_json
end

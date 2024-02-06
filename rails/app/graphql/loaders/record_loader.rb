# frozen_string_literal: true

module Loaders
  class RecordLoader < GraphQL::Dataloader::Source
    def initialize(model, column: model.primary_key)
      @model = model
      @column = column.to_s
      @column_type = model.type_for_attribute(@column)
    end

    def load(key)
      super(@column_type.cast(key))
    end

    def fetch(ids)
      records = @model.where(@column => ids)

      # return a list with `nil` for any ID that wasn't found
      # https://graphql-ruby.org/dataloader/sources.html
      ids.map { |id| records.find { |r| r.send(@column) == id } }
    end
  end
end

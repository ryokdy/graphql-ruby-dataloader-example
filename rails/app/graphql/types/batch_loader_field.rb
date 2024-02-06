# frozen_string_literal: true

class Types::BatchLoaderField < Types::BaseField
  def initialize(*args, loader: false, **kwargs, &block)
    case loader
    when :association_loader
      super(
        *args,
        resolver_method: :load_assoc,
        extras: [:graphql_name],
        **kwargs,
        &block
      )
    when :record_loader
      super(
        *args,
        resolver_method: :load_record,
        extras: [:graphql_name],
        **kwargs,
        &block
      )
    else
      super(*args, **kwargs, &block)
    end
  end
end

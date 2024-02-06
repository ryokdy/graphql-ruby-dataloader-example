# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    include GraphqlHelper

    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BatchLoaderField

    def load_assoc(graphql_name:)
      dataloader
        .with(Loaders::AssociationLoader, object.class, graphql_name.underscore)
        .load(object)
    end

    def load_record(graphql_name:)
      assoc_name = graphql_name.underscore
      dataloader
        .with(
          Loaders::RecordLoader,
          object.class.reflect_on_association(assoc_name.to_sym).klass
        )
        .load(object.send("#{assoc_name}_id"))
    end
  end
end

# lib/tasks/graphql.rake
namespace :graphql do
    desc "Dump the GraphQL schema to a file"
    task dump_schema: :environment do
      File.write('schema.graphql', BarcitizenSchema.to_definition)
    end
  end
  
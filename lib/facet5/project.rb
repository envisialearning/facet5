module Facet5
  class Project
    include Her::Model

    use_api Facet5.api

    class << self

      def create(authentication = {}, params = {})

        puts "FACET5 GEM"
        puts authentication.to_yaml
        puts params.to_yaml

        request_params = {
          client_details: authentication
        }.merge!(params)

        puts request_params.to_yaml

        puts request_params.stringify_keys.to_yaml

        post "project_add", request_params
      end

      #needs campaign guid, lists all assessments
      def get_assessments(id, params = {})
        get "/api/v1/projects/#{id}/participants", params
      end

    end

  end
end
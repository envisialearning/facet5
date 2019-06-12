module Facet5
  class Project
    include Her::Model

    use_api Facet5.api

    class << self

      def create(authentication = {}, params = {})
        request_params = {
          client_details: authentication
        }.merge!(params)

        post "project_add", request_params
      end

      #needs campaign guid, lists all assessments
      def get_assessments(authentication = {}, params = {})
        request_params = {
          client_details: authentication
        }.merge!(params)

        post "respondent_find", request_params
      end

    end

  end
end
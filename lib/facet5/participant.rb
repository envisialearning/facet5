module Facet5
  class Participant
    include Her::Model

    use_api Facet5.api

    class << self

      def create_participant(authentication = {}, params = {})
        #create participant to a project involves 2 steps
        #step 1 - respondent_add to add the respondent record, get access_id from that
        #step 2 - project_add_respondent to add the respondent to the project
        #step 3 - respondent_invite 'invite' the respondent to fill out the questionnaire, doesn't really send an email but allows to add the questionnaire

        #puts "FACET5 GEM"
        #puts authentication.to_yaml
        #puts params.to_yaml

        language = params[:language]

        respondent_params = {
          client_details: authentication,
          surname: params[:last_name],
          given_name: params[:first_name],
          email: params[:email]
        }

        respondent_response = post("respondent_add", respondent_params)

        #puts "RESPONDENT ADD"
        #puts respondent_response.to_yaml

        access_id = respondent_response[:access_id]

        project_add_respondent_params = {
          client_details: authentication,
          project_id: params[:project_id],
          access_id: access_id
        }

        #puts "PROJECT ADD"
        #puts project_add_respondent_params.to_yaml

        #add_respondent_response = post("project_add_respondent", project_add_respondent_params)


        project_invite_respondent_params = {
          client_details: authentication,
          project_id: params[:project_id],
          access_id: access_id,
          survey_id: "facet5",
          language: Facet5::Definitions.languages["#{language}"],
          norm_id: "",
          viewpoint: "self"
        }
        
        invite_respondent_response = post("respondent_invite", project_invite_respondent_params)

        response = {
          "access_id": access_id,
          "successful": true,
          "assessment_url": "https://www.facet5global.net/questionnaire/default.aspx?accessid=#{access_id}"
        }

        return response
      end

      def get_status(authentication = {}, id, language)
        #Facet5::Definitions.to_yaml

        respondent_params = {
          client_details: authentication,
          access_id: id,
          language: Facet5::Definitions.languages["#{language}"]
        }

        respondent_response = post("respondent_status", respondent_params)
        completion_date = respondent_response["response"]["facetprofile"]["productstatus"]["respondentsurvey"]["participant"]["@completeddate"]
        #get completion status by:
        #respondent_response["response"]["facetprofile"]["productstatus"]["respondentsurvey"]["participant"].to_yaml
        #respondent_response["response"]["facetprofile"]["productstatus"]["respondentsurvey"]["participant"]["@completeddate"].to_yaml

        response = {
          "successful": true,
          "assessment_url": "https://www.facet5global.net/questionnaire/default.aspx?accessid=#{id}",
          "completed": completion_date.nil? ? false : true,
          "completed_at": completion_date.nil? ? nil : completion_date
        }
        return response
      end

      def get_spotlight_pdf_report(authentication={}, id, language)
        report_params = {
          survey_id: "facet5",
          report_id: "spotlightpdf",
          language: Facet5::Definitions.languages["#{language}"],
          norm_id: "",
          lcid: Facet5::Definitions.locales["#{language}"],
          viewpoint: "self",
          access_id: id,
          "timezone-offset": Facet5::Definitions.timezones["#{language}"],
          force_purchase: true   
        }

        #puts "FACET5 GEM SPOTLIGHT REPORT"
        #puts authentication.to_yaml
        #puts id.to_yaml

        respondent_response = get_pdf_report(authentication, report_params)
        #puts respondent_response.to_yaml

        #https://www.facet5global.net/pdftemp/ce53ff7f-18f9-46da-82bf-d302bc6d65fc.pdf
        if respondent_response["successful"]
          response = {
            "successful": true,
            "report_url": "https://www.facet5global.net/pdftemp/#{respondent_response["response"]}"
          }
          return response
        else
          return respondent_response
        end
      end

      def get_facet5_profile_pdf_report(authentication={}, id, language)
        report_params = {
          survey_id: "facet5",
          report_id: "facet5pdf",
          language: Facet5::Definitions.languages["#{language}"],
          norm_id: "",
          lcid: Facet5::Definitions.locales["#{language}"],
          viewpoint: "self",
          access_id: id,
          "timezone-offset": Facet5::Definitions.timezones["#{language}"],
          force_purchase: true       
        }

        respondent_response = get_pdf_report(authentication, report_params)

        #https://www.facet5global.net/pdftemp/ce53ff7f-18f9-46da-82bf-d302bc6d65fc.pdf
        if respondent_response["successful"]
          response = {
            "successful": true,
            "report_url": "https://www.facet5global.net/pdftemp/#{respondent_response["response"]}"
          }
          return response
        else
          return respondent_response
        end
      end
      #generic report
      def get_pdf_report(authentication = {}, params={})
        respondent_params = {
          client_details: authentication
        }

        respondent_response = post("respondent_report", respondent_params.merge!(params))
        return respondent_response
      end

    end
  end
end
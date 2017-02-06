class ExceptionsController < ApplicationController
	# Response
    respond_to :html, :xml, :json

    # Details
    before_action :status

    # Layout
    layout :layout_status

    # Show
    def show
    	CustomMailer.email_admin_send_app_status_notification(@exception.message.to_s).deliver_later
        respond_with status: @status
    end

    protected

	    # Info
	    def status
	        @exception  = env['action_dispatch.exception']
	        @status     = ActionDispatch::ExceptionWrapper.new(env, @exception).status_code
	        @response   = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
	    end

	   # Format
	    def details
	        @details ||= {}.tap do |h|
		        I18n.with_options scope: [:exception, :show, @response], exception_name: @exception.class.name, exception_message: @exception.message do |i18n|
		            h[:name]    = i18n.t "#{@exception.class.name.underscore}.title", default: i18n.t(:title, default: @exception.class.name)
		            h[:message] = i18n.t "#{@exception.class.name.underscore}.description", default: i18n.t(:description, default: @exception.message)
		        end
	    	end
	  	end
	  	helper_method :details

    private

	    # Layout
	    def layout_status
	        @status.to_s == "404" ? "application" : "error_500_layout"
	    end
end

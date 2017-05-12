require 'json'

class SimpleMailController < ApplicationController

skip_before_action :verify_authenticity_token # so AWS callbacks are accepted

  def notification
    json = JSON.parse(request.raw_post)
    logger.info "bounce callback from AWS with #{json}"
    aws_needs_url_confirmed = json['SubscribeURL']
    if aws_needs_url_confirmed
      logger.info "AWS is requesting confirmation of the bounce handler URL"
      uri = URI.parse(aws_needs_url_confirmed)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.get(uri.request_uri)
    else
      logger.info "AWS has sent us the following bounce notification(s): #{json}"
      json['bounce']['bouncedRecipients'].each do |recipient|
      logger.info "AWS SES received a bounce on an email send attempt to #{recipient['emailAddress']}"
        if json['bounce']['bounceType'] == "Transient"
          #work with bounce counter if transient bounce
          check_bounce(recipient['emailAddress'])
        else
          #unsubscribe user if permanent bounce
          unsubscribe_from_email(recipient['emailAddress'], "Bounce")
        end
      end
    end
    render nothing: true, status: 200
  end

  def complaint
    json = JSON.parse(request.raw_post)
    logger.info "complaints callback from AWS with #{json}"
    aws_needs_url_confirmed = json['SubscribeURL']
    if aws_needs_url_confirmed
      logger.info "AWS is requesting confirmation of the complaints handler URL"
      uri = URI.parse(aws_needs_url_confirmed)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.get(uri.request_uri)
    else
      logger.info "AWS has sent us the following complaints notification(s): #{json}"
      json['complaint']['complainedRecipients'].each do |recipient|
        logger.info "AWS SES received a complaint on an email send attempt to #{recipient['emailAddress']}"
        # unsubscribe the user from our email
        unsubscribe_from_email(recipient['emailAddress'], "Complaint")
      end
    end
    render nothing: true, status: 200
  end

  private

  def unsubscribe_from_email(email, type)
    if person = Person.find_by(email: email)
      person.send_email = false
      person.save
      logger.info "AWS SES received a #{type} on an email send attempt to #{email}"
    end
    if user = User.find_by(email: email)
      user.send_email = false
      user.save
      logger.info "AWS SES received a #{type} on an email send attempt to #{email}"
    end
  end

  def check_bounce(email)
    if person = Person.find_by(email: email)
      if person.bounce_count > 2
        person.send_email = false
        person.save
      else
        person.bounce_count += 1
        person.save
      end
      logger.info "AWS SES received a transient bounce on an email send attempt to #{email}"
    end
    if user = User.find_by(email: email)
      if user.bounce_count > 2
        user.send_email = false
        user.save
      else
        user.bounce_count += 1
        user.save
      end
      logger.info "AWS SES received a transient bounce on an email send attempt to #{email}"
    end
  end
end

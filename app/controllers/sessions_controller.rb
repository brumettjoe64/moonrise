class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :new_admin, :create, :create_admin]
  
  def new
    render :layout => false
  end

  def new_admin
    render :layout => false
  end

  def create
    guest_by_email = (params[:login] != "") ? Guest.where('lower(email)=?', params[:login].downcase).first : nil
    #guest_by_email = Guest.find_by_email(params[:login])
    guest_by_sitekey = (params[:login] != "") ?  Guest.where('lower(sitekey)=?', params[:login].downcase).first : nil
    #guest_by_sitekey = Guest.find_by_sitekey(params[:login])
    if guest_by_email 
      if !guest_by_email.admin
        session[:guest_id] = guest_by_email.id
        redirect_to home_url
      else
        redirect_to login_admin_url(login: params[:login])
      end
    elsif guest_by_sitekey
      if guest_by_sitekey.registered?
        redirect_to login_url, alert: "use your registered email"
      else
        session[:guest_id] = guest_by_sitekey
        redirect_to home_url
      end
    else 
      redirect_to login_url, alert: "invalid login"
    end
  end

  def create_admin
    guest = Guest.where('lower(email)=?', params[:login].downcase).first
    if guest and guest.password == params[:password]
      session[:guest_id] = guest.id
      redirect_to home_url
    else
      redirect_to login_admin_url(login: params[:login]), alert:"wrong password"
    end
  end

  def destroy
    session[:guest_id] = nil
    redirect_to login_url, notice: "logged out"
  end

end

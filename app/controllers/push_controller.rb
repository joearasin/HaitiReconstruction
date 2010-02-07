class PushController < ApplicationController
  require 'flickr_fu'
  before_filter :auth, :if => :old?, :only => :index

  def index
    flickr = Flickr.new(YAML.load_file(FLICKR).merge(:token => Frob.active))
    render :text => 'We should do some uploads here.'
  end

  def resume
    Frob.active = params[:frob]
    redirect_to :action => 'index'
  end

protected
  def auth
    flickr = Flickr.new(FLICKR)
    redirect_to flickr.auth.url(:write)
  end

  def old?
    Frob.old?
  end
end

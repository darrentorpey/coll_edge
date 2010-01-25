class ApplicationController < ActionController::Base

  helper :all, :title

  protect_from_forgery

  include HoptoadNotifier::Catcher
end
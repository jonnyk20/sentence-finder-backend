class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def ping
    res = { ping: true }
    json_response(res)
  end
end

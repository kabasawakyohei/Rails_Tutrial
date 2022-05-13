class ApplicationController < ActionController::Base
  def geeting
    render html: "hello, world!"
  end

  def hoge
    render html: "hoge"
  end
end

class StaticPagesController < ApplicationController
  def home
    render html:"こんにちは"
  end

  def help
  end
end

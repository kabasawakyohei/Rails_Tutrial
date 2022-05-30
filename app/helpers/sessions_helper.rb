module SessionsHelper
  def log_in(user)
    # ユーザーのIdをセッションのパラメータの中に保持させる
    session[:user_id] = user.id
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 渡されたユーザーがカレントユーザーであればtrueを返す
  def current_user?(user)
    user && user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # ユーザーのセッションを永続的に保存する
  def remember(user)
    user.remember
     cookies.permanent.signed[:user_id] = user.id
     cookies.permanent[:remember_token] = user.remember_token
  end

  # 永続的セッションの破棄
  def forget(user)
    user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
  end

  # 記憶したurlにリダイレクトする
  def redirect_original_url(default)
    redirect_to(session[:url] || default)
    session.delete(:url)
  end

  # getリクエストで投げられてきたurlをセッションに記憶する
  def store_location 
    session[:url] = request.original_url if request.get?
  end
end

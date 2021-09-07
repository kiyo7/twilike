class ApplicationController < ActionController::Base
  # Railsの全コントローラの親クラスであるApplicationコントローラにmoduleを読み込ませると全てのコントローラーで使えるようになる
  include SessionsHelper
end

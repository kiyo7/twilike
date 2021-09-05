class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique:true
  end
  #ここではusersテーブルのemailカラムにインデックスを追加するためにadd_index(Railsのメソッド)を使っている。インデックス自体は一意性を強制しないが、オプションでunique: trueを指定することによって強制ができる
end

module ApplicationHelper

    #ページごとにタイトルを変える
  def full_title(page_title = '')
    base_title = "TwiLike"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
  end
  end
end

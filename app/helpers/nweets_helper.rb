module NweetsHelper
  # デフォのtime_ago_in_wordsのままだと「1分以内前」ってなっちゃうので…
  def time_ago_in_japanese(time)
    str = time_ago_in_words(time)
    if str.last(2) == "以内"
      str
    else
      str + "前"
    end
  end
end

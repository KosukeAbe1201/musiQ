module QuizSupport
  def fill_all_question(correct_num)
    fill_in "post[question]", with: "question"
    fill_in "post[answer1]", with: "answer1"
    fill_in "post[answer2]", with: "answer2"
    fill_in "post[answer3]", with: "answer3"
    fill_in "post[answer4]", with: "answer4"
    choose correct_num
    click_button "NEXT QUESTION"
  end

  def fill_keyword(keyword)
    fill_in "keyword[keyword]", with: keyword
    click_button "決定"
  end
end

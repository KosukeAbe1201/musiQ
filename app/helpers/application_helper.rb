module ApplicationHelper
  def redirect_to_with_ajax(path)
    respond_to do |format|
        format.html { redirect_to path }
        format.js
    end
  end
end

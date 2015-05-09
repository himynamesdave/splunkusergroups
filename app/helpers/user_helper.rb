module UserHelper
  def user_input_class(method)
    if @user.errors[method].any?
      'has-error'
    elsif @user.send(method).blank?
      ''
    else 
      'has-success'
    end
  end
end
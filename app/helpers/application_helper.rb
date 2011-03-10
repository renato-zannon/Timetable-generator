module ApplicationHelper

  def show_error_messages_for(object)
    return if object.nil?
    render 'shared/error_messages', :object => object
  end
  
end

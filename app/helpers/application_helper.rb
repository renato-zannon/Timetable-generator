module ApplicationHelper

  def show_error_messages_for(object)
    return if object.nil?
    @object = object
    render 'shared/error_messages'
  end
  
end

require 'group_constants'

class LessonTableValidator < ActiveModel::EachValidator

  include GroupConstants
  
  def validate_each(record, attribute, value)
    @record = record
    @attribute = attribute
    @value = value

    if not (@value.kind_of? Hash)
      record.errors[attribute] << "must be a hash"
      return
    end
    
    record.errors[attribute] << "must contain at least one week day" unless attribute_contain_week_days?
    record.errors[attribute] << "must contain at least one day with lessons" unless attribute_days_contain_lessons?
  end
  
  def attribute_contain_week_days?
    (@value.keys & week_days).count > 0    
  end
  
  def attribute_days_contain_lessons?
    attr_days = (@value.keys & week_days)
    attr_days.each do |day|
      return true if (@value[day] & all_lessons).count > 0
    end
    return false
  end
end

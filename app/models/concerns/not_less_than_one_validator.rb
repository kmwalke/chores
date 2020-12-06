class NotLessThanOneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # binding.pry
    unless value >= 1
      record.errors[attribute] << (options[:message] || "cannot be less than one")
    end
  end
end

class NotLessThanOneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || 'cannot be less than one') unless value >= 1
  end
end

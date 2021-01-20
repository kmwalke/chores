class TimeZoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.present? && ActiveSupport::TimeZone[value]

    record.errors.add(attribute, (options[:message] || 'is not a valid time zone!'))
  end
end

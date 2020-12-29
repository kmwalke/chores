module TimeZoneConverter
  extend ActiveSupport::Concern

  def today_in_zone(zone)
    Time.find_zone!(zone).today
  end

  def yesterday_in_zone(zone)
    Time.find_zone!(zone).yesterday
  end
end
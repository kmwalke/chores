module UrlValidator
  extend ActiveSupport::Concern

  def proper_url
    url_error unless url.blank? || uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    url_error
  end

  def url_error
    errors.add(:url, 'URL must be valid and start with http')
  end

  def uri
    @uri ||= URI.parse(url)
  end
end

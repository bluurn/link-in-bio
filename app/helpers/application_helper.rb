module ApplicationHelper
  def safe_external_url(url)
    url.to_s.start_with?("http://", "https://") ? url : "#"
  end
end

require 'securerandom'

class Url < ApplicationRecord
  validates :long_url, presence: true
  validate :is_a_real_url?
  validates :short_path, uniqueness: true
  before_save -> { self.short_path = generate_8_character_unique_url }

  # Rails' redirect_to requires an explicit protocol to redirect;
  # rather than forcing the user to type in http:// or https://
  # when shortening a url, prepend it when reading the short_url
  # field so that redirect_to works without any munging; there
  # are other protocols besides http:// and https:// that a
  # user may want to shorten, but chances are, if that's the case,
  # the user would have specified it when specifying the URL to
  # shorten, so we'll take a guess and apply http://; if the site
  # is https://, we degrade gracefully by expecting they know how to
  # forward http:// to https://
  def long_url_with_explicit_protocol
    URI.parse(long_url).instance_of?(URI::Generic) ? "http://#{long_url}" : long_url
  end

  private

  # Generate a new, 8-character short URL key
  #
  # Account for a few low-likelihood scenarios:
  # - since securerandom doesn't guarantee length after removing
  # non-alphanumeric characters, regenerate until we're sure we
  # have 8 characters
  # - preemptivey regenerate the URL key if it happens to exist in
  # the database already
  def generate_8_character_unique_url
    loop do
      random_short_path = SecureRandom.base64(12).gsub('+', '').gsub('/', '').gsub('=', '')[0..7]
      return random_short_path if (random_short_path.length == 8) && Url.where(short_path: random_short_path).count.zero?
    end
  end

  # Add a validation error if the URL is clearly bonk;
  # since the definition of a valid URL is somewhat
  # nebulous, be generous in allowing questionable URL's
  #
  # Inspired by https://gist.github.com/bluemont/2986523
  def is_a_real_url?
    begin
      URI.parse(long_url)
    rescue URI::InvalidURIError
      errors.add(:message, "must be a valid URL")
    end    
  end
end

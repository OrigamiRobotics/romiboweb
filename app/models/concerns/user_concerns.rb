module UserConcerns
  extend ActiveSupport::Concern

  def apply_omniauth(omniauth)
    data = {provider: omniauth.provider, uid: omniauth.uid,
            confirmation_token: nil}
    data.merge!( confirmed_at: Time.now) if confirmed_at.blank?
    update_attributes(data)
  end

  def encrypt_id
    data = "Very, very confidential data"

    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt

    encryption = cipher.update(data) + cipher.final
    encryption_key = cipher.random_key
    encryption_iv  = cipher.random_iv
  end

  def decrypted_id
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = encryption_key
    decipher.iv  = encryption_iv
    decipher.update(encryptd_id) + decipher.final
  end

  def other_names_and_avatars
    user_id = id
    User.where{id != user_id}.order(:first_name).map do |user|
      ["#{user.full_name},#{profile_avatar_url(user.profile)}", user.id]
    end
  end

  def palettes_to_recommend
    palettes.map do |palette|
      ["#{palette.title} (#{palette.buttons.size} buttons)", palette.id]
    end
  end

  def lessons_to_recommend
    lessons.map do |lesson|
      ["#{lesson.title[0..99]} ", lesson.id]
    end
  end
end

class User < ActiveRecord::Base

  def self.authenticate_with_credentials(email, password)

    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end





  has_secure_password



  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :password, length: {in: 6..71}



end

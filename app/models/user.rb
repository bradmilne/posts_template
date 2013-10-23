class User < ActiveRecord::Base

  has_many :posts, foreign_key: :user_id
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}

  after_validation :generate_slug

  def admin?
  	self.role == 'admin'
  end

  def moderator?
  	self.role == 'moderator'
  end

  def admin_or_current_user
    self.logged_in? || current_user.admin?  
  end

  def generate_slug
    self.slug = self.username.gsub(' ', '-').downcase
  end

  def to_param
    self.slug
  end
end
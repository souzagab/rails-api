class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  field :name, type: String
  field :email, type: String
  field :description, type: String
  field :password_digest, type: String

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /@/ 

  has_secure_password
end

require 'bcrypt'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String, required: true, unique: true,
    messages: { is_unique:  "Email taken.",
                presence:   "Email required."}
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

#  validates_presence_of :email
  validates_confirmation_of :password, message: "Password and confirmation password do not match."

end

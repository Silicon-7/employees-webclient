class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthday

  def initialize(hash)
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    @birthday = Date.parse(hash["birthday"])
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friendly_birthday
    birthday.strftime('%b %d, %Y')
  end
end
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

  def self.all
    employee_collection = []
    api_employees = Unirest.get("#{ ENV['API_HOST_URL'] }/api/v1/employees.json").body
    api_employees.each do |employee_hash|
      employee_collection << Employee.new(employee_hash)
    end
    employee_collection
  end

  def self.find(employee_id)
    Employee.new(Unirest.get("#{ ENV['API_HOST_URL'] }/api/v1/employees/#{ employee_id }.json").body)
  end
end


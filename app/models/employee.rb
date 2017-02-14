class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthday

  def initialize(hash={})
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    if hash["birthday"]
      @birthday = Date.parse(hash["birthday"])
    else
      @birthday = nil
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friendly_birthday
    if birthday
      birthday.strftime('%b %d, %Y')
    else
      "No Birthday Listed"
    end
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

  def destroy
    Unirest.delete(
                    "#{ ENV['API_HOST_URL'] }/api/v1/employees/#{ id }",
                    headers: {
                              "Accept" => "application/json"
                              }
                    ).body
  end

  def self.create(employee_info)
    response_body = Unirest.post(
                                "#{ ENV['API_HOST_URL'] }/api/v1/employees",
                                headers: {
                                          "Accept" => "application/json"
                                          },
                                parameters: employee_info
                                ).body
    Employee.new(response_body)
  end

  def update(employee_info)
    response_body = Unirest.patch(
                                  "#{ ENV['API_HOST_URL'] }/api/v1/employees/#{ id }",
                                  headers: {
                                            "Accept" => "application/json"
                                            },
                                  parameters: employee_info
                                  ).body
    Employee.new(response_body)
  end
end


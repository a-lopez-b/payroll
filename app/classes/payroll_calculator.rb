class PayrollCalculator

    attr_accessor :payroll_period, :employees
    attr_reader :employee_data

    def initialize(payroll_period)
        @payroll_period = payroll_period
    end
    
    def start
        employees.each do |employee| 
            EmployeeCalculator.new.perform(employee: employee, payroll_period: @payroll_period)
        end
    end

    private 

    def employees
        employees = Employee.select(:id).all
    end

    

end
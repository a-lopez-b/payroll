class EmployeeCalculator 

    Salary_code = 1
    Social_security_code = 11
    Tax_code = 10

    def perform(payroll_period:, employee:) 
      @payroll_period = payroll_period
      @new_payroll = Payroll.create( employee_id: employee.id, payroll_period_id: payroll_period.id, tax_amount: 0, ssn_amount: 0, net_amount: 0, status: true)
      
      days_to_pay_in_period(employee)
      calculate_social_security()
      calculate_tax(payroll_period: payroll_period, employee: employee)
      payroll_period.update_totals!
      
      Payroll.find(@new_payroll.id)
    end

    def days_to_pay_in_period(employee)
        concept = get_concept(Salary_code)
        qty = ((@payroll_period.end_date - @payroll_period.start_date).to_i) + 1 
        salary =  Salary.where(["employee_id = :employee_id and date <= :end_date", { employee_id: employee.id, end_date: @payroll_period.end_date}])
                        .order('date desc')
                        .first
        taxed = qty * salary.sdn
        create_payroll_detail(payroll: @new_payroll, concept: concept, quantity: qty, taxed: taxed, exempt: 0, retention: 0)
    end

    def calculate_social_security()
        concept = get_concept(Social_security_code)
        qty = 1
        ss_amount = 42.37 #pending to implement calculation
        create_payroll_detail(payroll: @new_payroll, concept: concept, quantity: qty, taxed: 0, exempt: 0, retention: ss_amount)
    end

    def calculate_tax(payroll_period:, employee:)
        monthly_income = EmployeeCumulativeIncome.new(payroll_period, employee).month
        days_worked_in_month = EmployeeWorkedDays.new(payroll_period, employee).month
        concept = get_concept(Tax_code)
        qty = 1
        tax_amount = Tax.new.calculate(monthly_income: monthly_income, days_worked_in_month: days_worked_in_month)
        create_payroll_detail(payroll: @new_payroll, concept: concept, quantity: qty, taxed: 0, exempt: 0, retention: tax_amount)
    end

    def get_concept(code)
        con = Concept.where(["code = :code",{code: code}]).first
    end

    def create_payroll_detail(payroll:, concept:, quantity:, taxed:, exempt:, retention:)
        PayrollDetail.create(payroll_id: payroll.id, concept_id: concept.id, concept_type: concept.concept_type, 
                             quantity: quantity, taxed: taxed, exempt: exempt, retention: retention)
    end

end
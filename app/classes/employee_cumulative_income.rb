class EmployeeCumulativeIncome
    
    def initialize(payroll_period, employee)
      @payroll_period = payroll_period
      @employee = employee
    end

    def payroll_period
      income = PayrollDetail.joins(payroll: [:payroll_period])
              .where('payroll_periods.id = ?', @payroll_period.id)
              .sum('payroll_details.taxed')       
    end

    def month
        income = PayrollDetail.joins(payroll: [:payroll_period])
                .where('payroll_periods.year = ? and payroll_periods.month = ? and payrolls.employee_id = ?', 
                        @payroll_period.year, @payroll_period.month, @employee.id)
                .sum('payroll_details.taxed')       
    end

    def year
        income = PayrollDetail.joins(payroll: [:payroll_period])
                .where('payroll_periods.year = ?', 
                        @payroll_period.year)
                .sum('payroll_details.taxed')
    end


end
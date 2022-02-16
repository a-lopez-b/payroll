require 'test_helper'

class PayrollCalculatorTest < ActiveSupport::TestCase
    test "test isr calculation" do
        income = 8557.5
        worked_days = 15
        employee = employees(:andres)
        tax = Tax.new.calculate(monthly_income: income, days_worked_in_month: worked_days)
        
        assert_equal 1116.78, tax.round(2)
    end
    
    test "verify total amounts and concepts quantities" do
        payroll_period = payroll_periods(:februaryfirst)
        employee = employees(:andres)
        payroll = EmployeeCalculator.new.perform(employee: employee, payroll_period: payroll_period)
        concepts = PayrollDetail.where('payroll_id = ?', payroll.id).count

        assert_equal 3, concepts 
        assert_equal payroll_period.net_amount.round(2), payroll.net_amount.round(2)
        assert_equal payroll_period.ssn_amount.round(2), payroll.ssn_amount.round(2)
        assert_equal payroll_period.tax_amount.round(2), payroll.tax_amount.round(2)
    end

end
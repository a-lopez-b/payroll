class PayrollPeriod < ApplicationRecord
    has_many :payroll

    def update_totals!
        self.update(net_amount: self.total_net_amounts, tax_amount: self.total_tax_amounts, ssn_amount: self.total_ssn_amounts)
    end

    def total_net_amounts
        Payroll.where('payrolls.payroll_period_id = ?', self.id).all.sum('payrolls.net_amount')
    end

    def total_tax_amounts
        Payroll.where('payrolls.payroll_period_id = ?', self.id).all.sum('payrolls.tax_amount')
    end

    def total_ssn_amounts
        Payroll.where('payrolls.payroll_period_id = ?', self.id).all.sum('payrolls.ssn_amount')
    end


end

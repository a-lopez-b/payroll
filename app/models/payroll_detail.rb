class PayrollDetail < ApplicationRecord
    belongs_to :payroll 
    belongs_to :concept

    after_create :update_payroll_amounts!
    after_destroy :update_payroll_amounts!

    private

    def update_payroll_amounts!
        self.payroll.update_tax_amount!
        self.payroll.update_ssn_amount!
        self.payroll.update_net_amount!
    end


end

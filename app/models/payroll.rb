class Payroll < ApplicationRecord
    belongs_to :payroll_period 
    belongs_to :employee
    has_many :payroll_detail

    
    def update_net_amount!
        self.update(net_amount: self.get_net_amount)
    end
    
    def update_tax_amount!
        self.update(tax_amount: self.get_tax_amount)
    end

    def update_ssn_amount!
        self.update(ssn_amount: self.get_ssn_amount)
    end

    def get_net_amount
        amount = PayrollDetail.where('payroll_id = ?', self.id).sum('payroll_details.taxed + payroll_details.exempt - payroll_details.retention')
    end

    def get_tax_amount
        amount = PayrollDetail.joins(:concept).where('payroll_id = ? and concepts.code = ?', self.id, 10).sum('payroll_details.retention')
    end

    def get_ssn_amount
        amount = PayrollDetail.joins(:concept).where('payroll_id = ? and concepts.code = ?', self.id, 11).sum('payroll_details.retention')
    end


end

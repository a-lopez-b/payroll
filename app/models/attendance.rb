class Attendance < ApplicationRecord
    belongs_to :employee
    belongs_to :payroll_period
    belongs_to :payroll
    belongs_to :payroll_detail
end

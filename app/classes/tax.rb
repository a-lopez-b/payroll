class Tax
    Days_in_month = 30.4
    Tax_table = [
                    {inferior_limit:0.01, superior_limit:644.58, fixed_fee:0.00, percentage:1.92}, 
                    {inferior_limit:644.59, superior_limit:5470.92, fixed_fee:12.38, percentage:6.40}, 
                    {inferior_limit:5470.93, superior_limit:9614.66, fixed_fee:321.26, percentage:10.88}, 
                    {inferior_limit:9614.67, superior_limit:11176.62, fixed_fee:772.10, percentage:16.00}, 
                    {inferior_limit:11176.63, superior_limit:13381.47, fixed_fee:1022.01, percentage:17.92}, 
                    {inferior_limit:13381.48, superior_limit:26988.50, fixed_fee:1417.12, percentage:21.36},
                    {inferior_limit:26988.51, superior_limit:42537.58, fixed_fee:4323.58, percentage:23.52}, 
                    {inferior_limit:42537.59, superior_limit:81211.25, fixed_fee:7980.73, percentage:30.00}, 
                    {inferior_limit:81211.26, superior_limit:108281.67, fixed_fee:19582.83, percentage:32.00},
                    {inferior_limit:108281.68, superior_limit:324845.01, fixed_fee:28245.36, percentage:34.00}, 
                    {inferior_limit:324845.02, superior_limit:99999999.99, fixed_fee:101876.90, percentage:35.00}
                ];
    
    Subsidy_table = [
                    {inferior_limit:0.01, superior_limit:1768.96, subsidy:407.02},
                    {inferior_limit:1768.97, superior_limit:2653.38, subsidy:406.83},
                    {inferior_limit:2653.39, superior_limit:3472.84, subsidy:406.62},
                    {inferior_limit:3472.85, superior_limit:3537.87, subsidy:392.77},
                    {inferior_limit:3537.88, superior_limit:4446.15, subsidy:382.46},
                    {inferior_limit:4446.16, superior_limit:4717.18, subsidy:354.23},
                    {inferior_limit:4717.19, superior_limit:5335.42, subsidy:324.87},
                    {inferior_limit:5335.43, superior_limit:6224.67, subsidy:294.63},
                    {inferior_limit:6224.68, superior_limit:7113.90, subsidy:253.54},
                    {inferior_limit:7113.91, superior_limit:7382.33, subsidy:217.61},
                    {inferior_limit:7382.34, superior_limit:9999999.99,	subsidy:0.00}
                ];

    def calculate(monthly_income:, days_worked_in_month:)
        monthly_tax = calculate_monthly_tax(income: monthly_income, days_worked_in_month: days_worked_in_month)
        monthly_subsidy = calculate_monthly_subsidy(monthly_income)
        calculate_period_tax(tax: monthly_tax, subsidy: monthly_subsidy, worked_days: days_worked_in_month)
    end

    private

    def calculate_monthly_tax(income:, days_worked_in_month:)
        base_income = calculate_base_income(income: income, days_worked_in_month: days_worked_in_month);
        tax_formula(base_income)
    end

    def calculate_monthly_subsidy(income)
        Subsidy_table.each do |sub_row|
            if income.between?(sub_row[:inferior_limit],sub_row[:superior_limit])  
                return sub_row[:subsidy]
            end
        end
    end

    def calculate_base_income(income:, days_worked_in_month:)
        daily_revenue = income / days_worked_in_month 
        base_income = daily_revenue * Days_in_month
    end

    def calculate_period_tax(tax:, subsidy:, worked_days:)
        net_tax = tax - subsidy
        daily_tax = net_tax / Days_in_month
        daily_tax * worked_days
    end
    
    def tax_formula(income)
        tax_row = tax_parameters(income);
        ((income - tax_row[:inferior_limit]) * (tax_row[:percentage]/100)) + tax_row[:fixed_fee]
    end

    def tax_parameters(income)
        Tax_table.each do |tax_row|
            if income.between?(tax_row[:inferior_limit],tax_row[:superior_limit])  
                return tax_row
            end
        end
    end

end
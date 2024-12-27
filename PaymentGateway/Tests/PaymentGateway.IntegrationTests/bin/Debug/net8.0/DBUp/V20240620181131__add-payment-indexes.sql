CREATE INDEX idx_company_merchant_numeric_date_delete ON daily_report (company_id, merchant_id, numeric_date, is_delete);
CREATE INDEX idx_numeric_date_delete ON daily_report (numeric_date, is_delete);
CREATE INDEX idx_company_merchant_year_delete ON daily_report (company_id, merchant_id, day_of_year, is_delete);
CREATE INDEX idx_company_merchant_delete ON daily_report (company_id, merchant_id, is_delete);
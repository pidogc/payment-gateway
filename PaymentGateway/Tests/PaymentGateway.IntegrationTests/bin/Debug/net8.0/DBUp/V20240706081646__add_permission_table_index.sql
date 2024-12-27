CREATE INDEX idx_permission_id_permission_code ON permission (id, permission_code, is_delete);

CREATE INDEX idx_role_permission_company_and_merchant_id ON role_permission (company_id, merchant_id,role_id,permission_id,is_delete);

CREATE INDEX idx_role_company_and_merchant_id ON role (id, company_id, merchant_id,is_delete);

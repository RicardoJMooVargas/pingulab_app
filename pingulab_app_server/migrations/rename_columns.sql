-- Renombrar columnas a camelCase
ALTER TABLE printers RENAME COLUMN purchase_cost TO "purchaseCost";
ALTER TABLE quotes RENAME COLUMN depreciation_cost TO "depreciationCost";
ALTER TABLE quotes RENAME COLUMN created_by TO "createdBy";
ALTER TABLE quotes RENAME COLUMN updated_by TO "updatedBy";

SELECT 'Columnas renombradas exitosamente' as status;

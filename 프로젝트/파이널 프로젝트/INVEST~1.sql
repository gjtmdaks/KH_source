CREATE TABLE stock_sector_temp (
    stock_code VARCHAR2(10),
    stock_name VARCHAR2(100),
    sector VARCHAR2(100)
);

UPDATE stocks s
SET s.sector = (
    SELECT t.sector
    FROM stock_sector_temp t
    WHERE t.stock_code = s.stock_code
)
WHERE EXISTS (
    SELECT 1
    FROM stock_sector_temp t
    WHERE t.stock_code = s.stock_code
);


DROP TABLE co_information;

CREATE TABLE co_information (
    corp_code VARCHAR2(10) PRIMARY KEY,
    stock_code VARCHAR2(8),
    co_name VARCHAR2(100),

    issued_stock NUMBER,
    declined_stock NUMBER,
    treasury_stock NUMBER,
    outstanding_shares NUMBER,

    minority_shareholder_ratio NUMBER(5,2),
    minority_ownership_ratio NUMBER(5,2),

    updated_at DATE
);

ALTER TABLE STOCK_HISTORY_CACHE
ADD CONSTRAINT UK_HISTORY
UNIQUE (STOCK_CODE, PERIOD_TYPE, BASE_DATE);

DROP VIEW IF EXISTS dm_v24_delay_vs_score;
CREATE VIEW dm_v24_delay_vs_score AS
-- SELECT ... FROM core_order / core_item ... WHERE ... GROUP BY ...
SELECT
    order_id,
    purchase_month AS month,
    region,
    delay_days,
    CASE
        WHEN delay_days <= 0 THEN 'Доставлено вовремя'
        WHEN delay_days BETWEEN 1 AND 3 THEN 'Задержка 1-3 дня'
        WHEN delay_days BETWEEN 4 AND 7 THEN 'Задержка 4-7 дней'
        ELSE 'Задержка более 7 дней'
    END AS delay_group,

    CASE
        WHEN delay_days <= 0 THEN 'Вовремя'
        ELSE 'С опозданием'
    END AS delivery_status,

    review_score
FROM core_order
WHERE order_status = 'delivered'
  AND review_score IS NOT NULL;

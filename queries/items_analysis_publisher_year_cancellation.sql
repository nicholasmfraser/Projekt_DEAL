SELECT
  article_pubyear, publisher, cancellation_year, COUNT(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    t1.article_doi,
    t1.article_pubyear,
    CASE WHEN t2.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher,
    t4.cancellation_year
  FROM
    projekt_deal.deal_items_analysis t1
  INNER JOIN
    projekt_deal.cr_jan21 t2
  ON
    t1.article_doi = t2.doi
  INNER JOIN
    projekt_deal.deal_authors_institutions t3
  ON
    t1.article_id = t3.article_id
  INNER JOIN
    projekt_deal.deal_grid_mapping t4
  ON
    t3.institution_grid = t4.grid)
GROUP BY article_pubyear, publisher, cancellation_year
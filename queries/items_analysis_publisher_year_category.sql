SELECT
  article_pubyear, publisher, category_name, COUNT(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    t1.article_pubyear, 
    CASE WHEN t2.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher,
    t3.category_name, 
    t1.article_doi
  FROM
    projekt_deal.deal_items_analysis t1
  INNER JOIN
    projekt_deal.cr_jan21 t2
  ON
    t1.article_doi = t2.doi
  INNER JOIN
    projekt_deal.deal_categories t3
  ON
    t1.article_id = t3.article_id)
GROUP BY article_pubyear, publisher, category_name
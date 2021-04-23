SELECT
  article_pubyear, publisher, COUNT(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    t1.article_pubyear,
    CASE WHEN t2.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher,
    t1.article_doi
  FROM
    projekt_deal.deal_items_analysis t1
  INNER JOIN
    projekt_deal.cr_jan21 t2
  ON
    t1.article_doi = t2.doi)
GROUP BY article_pubyear, publisher
SELECT
  article_pubyear, publisher, oa_status, COUNT(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    t1.article_pubyear, 
    CASE WHEN t2.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher,
    t3.oa_status, 
    t1.article_doi
  FROM
    projekt_deal.deal_items_analysis t1
  INNER JOIN
    projekt_deal.cr_jan21 t2
  ON
    t1.article_doi = t2.doi
  INNER JOIN
    projekt_deal.upw_Feb21_08_21 t3
  ON
    t1.article_doi = t3.doi)
GROUP BY article_pubyear, publisher, oa_status

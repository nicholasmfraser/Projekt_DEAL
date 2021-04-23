SELECT DISTINCT
  article_pubyear, publisher, institution_name, COUNT(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    t1.article_doi, t1.article_pubyear, t2.institution_name, 
    CASE WHEN t3.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher,
  FROM 
    projekt_deal.deal_items_analysis t1
  INNER JOIN
    projekt_deal.deal_authors_institutions t2
  ON
    t1.article_id = t2.article_id
  INNER JOIN
    projekt_deal.cr_jan21 t3
  ON
    t1.article_doi = t3.doi
  WHERE
    t2.institution_is_deal IS TRUE)
GROUP BY
  article_pubyear, publisher, institution_name
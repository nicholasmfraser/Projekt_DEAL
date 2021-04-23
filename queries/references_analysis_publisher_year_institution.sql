SELECT
  article_pubyear, publisher, institution_name,
  COUNT(*) AS n_refs
FROM (
  SELECT DISTINCT
    t2.article_doi_citing,
    t2.article_doi_cited,
    t1.article_pubyear,
    t4.institution_name,
    CASE WHEN t3.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher
  FROM
    projekt_deal.deal_items_analysis t1
  INNER JOIN
    projekt_deal.deal_references_analysis t2
  ON
    t1.article_doi = t2.article_doi_citing
  INNER JOIN
    projekt_deal.cr_jan21 t3
  ON
    t2.article_doi_cited = t3.doi
  INNER JOIN
    projekt_deal.deal_authors_institutions t4
  ON
    t1.article_id = t4.article_id
  INNER JOIN
    projekt_deal.deal_grid_mapping t5
  ON
    t4.institution_grid = t5.grid
  WHERE
    (t1.article_pubyear - t3.issued_year) >= 0 AND
    (t1.article_pubyear - t3.issued_year) <= 2)
GROUP BY
  article_pubyear, publisher, institution_name
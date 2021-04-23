SELECT
  article_pubyear, citation_year, publisher,
  COUNT(*) AS n_refs
FROM (
  SELECT DISTINCT
    t2.article_doi_citing,
    t2.article_doi_cited,
    t1.article_pubyear,
    (t1.article_pubyear - t3.issued_year) AS citation_year,
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
    t2.article_doi_cited = t3.doi)
WHERE
  citation_year >= 0
  AND citation_year <= 5
GROUP BY
  article_pubyear, citation_year, publisher
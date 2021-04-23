SELECT
  n_refs, COUNT(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    t1.article_doi,
    COUNT(DISTINCT t2.article_doi_cited) AS n_refs
  FROM
    projekt_deal.deal_items t1
  LEFT JOIN
    projekt_deal.deal_references t2
  ON
    t1.article_doi = t2.article_doi_citing
  GROUP BY t1.article_doi)
GROUP BY n_refs
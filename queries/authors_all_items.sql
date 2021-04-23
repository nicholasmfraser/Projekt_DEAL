SELECT
  n_authors, COUNT(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    t1.article_doi, MAX(t2.author_position) as n_authors
  FROM
    projekt_deal.deal_items t1
  INNER JOIN
    projekt_deal.deal_authors_institutions t2
  ON
    t1.article_id = t2.article_id
  GROUP BY
    t1.article_doi)
GROUP BY
  n_authors
SELECT
  t2.member, COUNT (DISTINCT t1.article_doi) AS n_items
FROM
  projekt_deal.deal_items t1
INNER JOIN
  projekt_deal.cr_jan21 t2
ON
  t1.article_doi = t2.doi
GROUP BY t2. member


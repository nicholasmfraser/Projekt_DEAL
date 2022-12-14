SELECT
  t1.article_pubyear, t2.publisher, t2.member, COUNT(t1.article_doi) AS n_items
FROM 
    projekt-deal.projekt_deal.deal_items_analysis t1
  INNER JOIN
    projekt-deal.projekt_deal.cr_jan21 t2
  ON
    t1.article_doi = t2.doi
  INNER JOIN
    projekt-deal.projekt_deal.upw_Feb21_08_21 t3
  ON
    t1.article_doi = t3.doi
WHERE t3.oa_status ="hybrid"
GROUP BY t1.article_pubyear, t2.publisher, t2.member
ORDER BY article_pubyear, n_items desc


SELECT
  article_pubyear, COUNT(DISTINCT article_doi) AS n_items
FROM 
  projekt_deal.deal_items t1
GROUP BY 
  article_pubyear
SELECT
  article_pubyear, deal_first_author, deal_last_author, count(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    article_doi, article_pubyear,  
    SUM(CASE WHEN author_position = 1 AND deal_author = 1 THEN 1 ELSE 0 END) AS deal_first_author,
    SUM(CASE WHEN author_position = n_authors AND deal_author = 1 THEN 1 ELSE 0 END) AS deal_last_author
  FROM (
    SELECT DISTINCT
      article_doi, article_pubyear, author_position, 
      MAX(author_position) OVER(PARTITION BY article_doi, article_pubyear) AS n_authors,
      MAX(CASE WHEN institution_is_deal IS TRUE THEN 1 ELSE 0 END) AS deal_author
    FROM
      projekt_deal.deal_items t1
    INNER JOIN
      projekt_deal.deal_authors_institutions t2
    ON
      t1.article_id = t2.article_id
    GROUP BY
      article_doi, article_pubyear, author_position)
  GROUP BY
    article_doi, article_pubyear
)
GROUP BY
  article_pubyear, deal_first_author, deal_last_author



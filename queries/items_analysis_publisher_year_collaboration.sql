SELECT
  article_pubyear, publisher, collaboration_status, count(article_doi) AS n_items
FROM (
  SELECT DISTINCT
    article_doi, article_pubyear, publisher,
    CASE WHEN MAX(author_position) = 1 THEN 'single-author'
         WHEN SUM(non_deal_author) = 0 AND SUM(non_de_author) = 0 THEN 'deal-collaboration'
         WHEN SUM(non_deal_author) >= 1 AND SUM(non_de_author) = 0 THEN 'national-collaboration'
         WHEN SUM(non_de_author) >= 1 THEN 'international-collaboration' END AS collaboration_status
  FROM (
    SELECT DISTINCT
      t1.article_doi, t1.article_pubyear, t2.author_position, 
      CASE WHEN t3.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher,
      CASE WHEN t2.institution_is_deal IS TRUE THEN 0 ELSE 1 END AS non_deal_author,
      CASE WHEN t2.institution_country = 'DE' THEN 0 ELSE 1 END AS non_de_author
    FROM 
      projekt_deal.deal_items_analysis t1
    INNER JOIN
      projekt_deal.deal_authors_institutions t2
    ON
      t1.article_id = t2.article_id
    INNER JOIN
      projekt_deal.cr_jan21 t3
    ON
      t1.article_doi = t3.doi)
  GROUP BY
    article_doi, article_pubyear, publisher)
GROUP BY
  article_pubyear, publisher, collaboration_status


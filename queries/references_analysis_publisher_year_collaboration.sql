SELECT
  article_pubyear, publisher, collaboration_status,
  COUNT(article_doi_cited) AS n_refs,
  COUNT(DISTINCT article_doi_citing) AS n_items
FROM (
  SELECT DISTINCT
    article_doi_citing, article_doi_cited, article_pubyear, publisher,
    CASE WHEN SUM(non_deal_author) = 0 AND SUM(non_de_author) = 0 THEN 'deal-collaboration'
         WHEN SUM(non_deal_author) >= 1 AND SUM(non_de_author) = 0 THEN 'national-collaboration'
         WHEN SUM(non_de_author) >= 1 THEN 'international-collaboration' END AS collaboration_status
  FROM (
    SELECT DISTINCT
      t2.article_doi_citing,
      t2.article_doi_cited,
      t1.article_pubyear,
      CASE WHEN t3.member = '78' THEN 'Elsevier' ELSE 'Non-Elsevier' END AS publisher,
      CASE WHEN t4.institution_is_deal IS TRUE THEN 0 ELSE 1 END AS non_deal_author,
      CASE WHEN t4.institution_country = 'DE' THEN 0 ELSE 1 END AS non_de_author
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
    WHERE
      (t1.article_pubyear - t3.issued_year) >= 0 AND
      (t1.article_pubyear - t3.issued_year) <= 2)
  GROUP BY
    article_doi_citing, article_doi_cited, article_pubyear, publisher)
GROUP BY
  article_pubyear, publisher, collaboration_status
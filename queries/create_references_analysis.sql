CREATE TABLE projekt_deal.deal_references_analysis AS SELECT
    *
FROM 
    projekt_deal.deal_references
WHERE
    article_doi_citing IN (SELECT article_doi FROM deal_items_analysis)
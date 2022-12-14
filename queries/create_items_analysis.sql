CREATE TABLE projekt_deal.deal_items_analysis AS (
    WITH deal_first_last_authors AS (
        SELECT
            article_doi
        FROM (
            SELECT
                article_doi,
                MAX(CASE WHEN author_position = 1 AND deal_author = 1 THEN 1 ELSE 0 END) AS deal_first_author,
                MAX(CASE WHEN author_position = n_authors AND deal_author = 1 THEN 1 ELSE 0 END) AS deal_last_author
            FROM (
                SELECT DISTINCT
                    t1.article_doi, t2.author_position, 
                    MAX(author_position) OVER(PARTITION BY article_doi) AS n_authors,
                    MAX(CASE WHEN institution_is_deal IS TRUE THEN 1 ELSE 0 END) AS deal_author
                FROM
                    projekt_deal.deal_items t1
                INNER JOIN
                    projekt_deal.deal_authors_institutions t2
                ON
                    t1.article_id = t2.article_id
                GROUP BY
                    t1.article_doi, t2.author_position
                )
            GROUP BY
                article_doi
            )
        WHERE
            deal_first_author = 1
            AND deal_last_author = 1
        ),
    deal_multi_references AS (
        SELECT
            article_doi
        FROM (
            SELECT DISTINCT
                article_doi_citing AS article_doi,
                COUNT(article_doi_cited) OVER (PARTITION BY article_doi_citing) AS n_refs
            FROM
                projekt_deal.deal_references
            )
        WHERE
            n_refs > 1
        ),
    not_acs AS(
        SELECT
            t1.article_doi
        FROM
            projekt_deal.deal_items t1
        INNER JOIN
            projekt_deal.cr_jan21 t2
        ON
            t1.article_doi = t2.doi
        WHERE NOT
            t2.member = '316'
    )
    SELECT
        *
    FROM 
        projekt_deal.deal_items t1
    WHERE
        t1.article_doi IN (SELECT article_doi FROM deal_first_last_authors) AND 
        t1.article_doi IN (SELECT article_doi FROM deal_multi_references) AND
        t1.article_doi IN (SELECT article_doi FROM not_acs)
    )

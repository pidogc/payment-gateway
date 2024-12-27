BEGIN;
ALTER TABLE marketing_center_member_level_benefit
    MODIFY `id` VARCHAR (36) DEFAULT '' NOT NULL,
    MODIFY `platform_id` VARCHAR (36) NOT NULL,
    MODIFY `benefit_id` VARCHAR (36) NOT NULL;

ALTER TABLE marketing_center_member_benefit
    MODIFY `id` VARCHAR (36) DEFAULT '' NOT NULL,
    MODIFY `platform_id` VARCHAR (36) NOT NULL,
    MODIFY `member_id` VARCHAR (36) NOT NULL,
    MODIFY `benefit_id` VARCHAR (36) NOT NULL;

ALTER TABLE marketing_center_benefit_product
    MODIFY `id` VARCHAR (36) DEFAULT '' NOT NULL,
    MODIFY `member_benefits_id` VARCHAR (36) NOT NULL,
    MODIFY `associated_id` VARCHAR (36) NOT NULL,
    ADD `term_days` INT UNSIGNED DEFAULT 0,
    DROP `term_begin_at`,
    DROP`term_end_at`;

ALTER TABLE marketing_center_benefit
    MODIFY `id` VARCHAR (36) DEFAULT '' NOT NULL,
    MODIFY `platform_id` VARCHAR (36) DEFAULT '' NOT NULL;
COMMIT;
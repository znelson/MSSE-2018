--1. How many hero combos are there that contain at least one hero from each team?
-- Find each hero combo that contain at least one hero from each team.
DROP TABLE HW4_1H_FROM_EACH_TEAM;
DROP TABLE HW4_1H_FROM_EACH_TEAM_PROJECT;
exec ops.go(ops.filter_ra('HW4_HERO_COMBO_W_ALL_STAT','AVENGERS_CARD_TYPE_COUNT>0 AND SPIDERFRIENDS_CARD_TYPE_COUNT>0 AND XMEN_CARD_TYPE_COUNT>0 AND SHIELD_CARD_TYPE_COUNT>0','HW4_1H_FROM_EACH_TEAM'));
exec ops.go(ops.project_ra('HW4_1H_FROM_EACH_TEAM','COMBO_ID, HERO_COUNT, AVENGERS_CARD_TYPE_COUNT, SPIDERFRIENDS_CARD_TYPE_COUNT, XMEN_CARD_TYPE_COUNT, SHIELD_CARD_TYPE_COUNT','HW4_1H_FROM_EACH_TEAM_PROJECT'));




--2. How many hero combos are there that contain one card of each color (i.e. class name)?
-- Find each hero combo that contain one card of each color.
DROP TABLE HW4_1C_FROM_EACH_TEAM;
DROP TABLE HW4_1C_FROM_EACH_TEAM_PROJECT;
exec ops.go(ops.filter_ra('HW4_HERO_COMBO_W_ALL_STAT','REFLEXES_CARD_TYPE_COUNT>0 AND STRENGTH_CARD_TYPE_COUNT>0 AND RANGED_CARD_TYPE_COUNT>0 AND INTUITION_CARD_TYPE_COUNT>0 AND TECH_CARD_TYPE_COUNT>0','HW4_1C_FROM_EACH_TEAM'));
exec ops.go(ops.project_ra('HW4_1C_FROM_EACH_TEAM','COMBO_ID, HERO_COUNT, REFLEXES_CARD_TYPE_COUNT, STRENGTH_CARD_TYPE_COUNT, RANGED_CARD_TYPE_COUNT, INTUITION_CARD_TYPE_COUNT, TECH_CARD_TYPE_COUNT','HW4_1C_FROM_EACH_TEAM_PROJECT'));




--3. How many 5 hero combos are there that contain at least one hero from each team and one card of each color?
-- Find each 5-hero combo that contain at least one hero from each team and one card from each color.
DROP TABLE HW4_1H_1C_FROM_EACH_TEAM;
DROP TABLE HW4_1H1C_5COMBO;
exec ops.go(ops.intersect_ra('HW4_1H_FROM_EACH_TEAM', 'HW4_1C_FROM_EACH_TEAM', 'HW4_1H_1C_FROM_EACH_TEAM'));
exec ops.go(ops.filter_ra('HW4_1H_1C_FROM_EACH_TEAM','HERO_COUNT=5','HW4_1H1C_5COMBO'));




--4. How many 6-hero combos are there that are gender balance (i.e. 3 females in 6-combo) and 3 heros from a single team?
-- Find each 6-hero combo that is gender balanced, and 3 of which are in a single team.
DROP TABLE HW4_GEN_BALANCED_COMBO;
exec ops.go(ops.filter_ra('HW4_HERO_COMBO_W_ALL_STAT','HERO_COUNT=6 AND FEMALE_HERO_COUNT=3 AND (AVENGERS_CARD_TYPE_COUNT=12 OR SPIDERFRIENDS_CARD_TYPE_COUNT=12 OR XMEN_CARD_TYPE_COUNT=12 OR SHIELD_CARD_TYPE_COUNT=12)','HW4_TEMP1'));
exec ops.go(ops.project_ra('HW4_TEMP1','COMBO_ID, FEMALE_HERO_COUNT, AVENGERS_CARD_TYPE_COUNT, SPIDERFRIENDS_CARD_TYPE_COUNT, XMEN_CARD_TYPE_COUNT, SHIELD_CARD_TYPE_COUNT','HW4_GEN_BALANCED_COMBO'));
DROP TABLE HW4_TEMP1;



--5. How many hero combos are there that contain exactly 1 team? (What about 0 team?)
-- Find each hero combo that contain exactly 1 team.
DROP TABLE HW4_ONE_TEAM_COMBO;
DROP TABLE HW4_ONE_TEAM_COMBO_PROJECT;
DECLARE
BEGIN
ops.go(
ops.filter_ra(
  'HW4_HERO_COMBO_W_ALL_STAT',
	'(case when AVENGERS_CARD_TYPE_COUNT>0 then 1 else 0 end 
+ case when SPIDERFRIENDS_CARD_TYPE_COUNT>0 then 1 else 0 end 
+ case when XMEN_CARD_TYPE_COUNT>0 then 1 else 0 end 
+ case when SHIELD_CARD_TYPE_COUNT>0 then 1 else 0 end)= 1', -- or (<3) for less than 3 teams
	'HW4_ONE_TEAM_COMBO'));
END;
/
exec ops.go(ops.project_ra('HW4_ONE_TEAM_COMBO','COMBO_ID, HERO_COUNT, AVENGERS_CARD_TYPE_COUNT, SPIDERFRIENDS_CARD_TYPE_COUNT, XMEN_CARD_TYPE_COUNT, SHIELD_CARD_TYPE_COUNT' ,'HW4_ONE_TEAM_COMBO_PROJECT'));




--6. How many hero combos are there that have exactly 1 color? (or 2, 3..etc. ?)
-- Find each hero combo that has exactly 4 colors.
DROP TABLE HW4_ONE_COLOR_COMBO;
DROP TABLE HW4_ONE_COLOR_COMBO_PROJECT;
DECLARE
BEGIN
ops.go(
ops.filter_ra(
  'HW4_HERO_COMBO_W_ALL_STAT',
	'(case when REFLEXES_CARD_TYPE_COUNT>0 then 1 else 0 end 
+ case when STRENGTH_CARD_TYPE_COUNT>0 then 1 else 0 end 
+ case when RANGED_CARD_TYPE_COUNT>0 then 1 else 0 end 
+ case when INTUITION_CARD_TYPE_COUNT>0 then 1 else 0 end 
+ case when TECH_CARD_TYPE_COUNT>0 then 1 else 0 end)= 4', -- Anything less than 4 gives 0 results
	'HW4_ONE_COLOR_COMBO'));
END;
/
exec ops.go(ops.project_ra('HW4_ONE_COLOR_COMBO','COMBO_ID, HERO_COUNT, REFLEXES_CARD_TYPE_COUNT, STRENGTH_CARD_TYPE_COUNT, RANGED_CARD_TYPE_COUNT, INTUITION_CARD_TYPE_COUNT, TECH_CARD_TYPE_COUNT' ,'HW4_ONE_COLOR_COMBO_PROJECT'));




--7. What is the “REDDEST” 5,6-hero combo (perhaps with ties)? (This could mean different things, with tiebreaker conditions)
-- Find each 5-hero or 6-hero combo that is the “REDDEST” (by card_count, card_type_count, or product of both).
DROP TABLE HW4_RED_COMBO;
DROP TABLE HW4_REDDEST_5COMBO_COUNT;
DROP TABLE HW4_REDDEST_6COMBO_COUNT;
DROP TABLE HW4_REDDEST_5COMBO;
DROP TABLE HW4_REDDEST_6COMBO;
DROP TABLE HW4_REDDEST_6COMBO;
DROP TABLE HW4_REDDEST_56COMBO;
DROP TABLE HW4_REDDEST_56COMBO_PROJECT;
DROP TABLE HW4_REDDEST_ALL_COMBO;

DECLARE
BEGIN
ops.go(
ops.group_ra(
  'HW4_HERO_COMBO_W_ALL_STAT',
  'REFLEXES_CARD_TYPE_COUNT, REFLEXES_CARD_COUNT, HERO_COUNT',
  'N_GROUP = count(*), 
PRODUCT5=(case when HERO_COUNT=5 then REFLEXES_CARD_TYPE_COUNT*REFLEXES_CARD_COUNT else 0 end), 
PRODUCT6=(case when HERO_COUNT=6 then REFLEXES_CARD_TYPE_COUNT*REFLEXES_CARD_COUNT else 0 end)', 'HW4_RED_COMBO'));
END;
/
exec ops.go(ops.group_ra('HW4_RED_COMBO', 'MAXIMUM5=max(PRODUCT5)', 'HW4_REDDEST_5COMBO_COUNT'));
exec ops.go(ops.group_ra('HW4_RED_COMBO', 'MAXIMUM6=max(PRODUCT6)', 'HW4_REDDEST_6COMBO_COUNT'));
exec ops.go(ops.mjoin_ra('HW4_RED_COMBO', 'HW4_REDDEST_5COMBO_COUNT', 'PRODUCT5', 'MAXIMUM5', 'HW4_REDDEST_5COMBO'));
exec ops.go(ops.mjoin_ra('HW4_RED_COMBO', 'HW4_REDDEST_6COMBO_COUNT', 'PRODUCT6', 'MAXIMUM6', 'HW4_REDDEST_6COMBO'));
exec ops.go(ops.union_ra('HW4_REDDEST_5COMBO', 'HW4_REDDEST_6COMBO', 'HW4_REDDEST_56COMBO'));
exec ops.go(ops.project_ra('HW4_REDDEST_56COMBO', 'REFLEXES_CARD_COUNT, REFLEXES_CARD_TYPE_COUNT, HERO_COUNT, COLOR_PRODUCT=(case when PRODUCT5=0 then PRODUCT6 else PRODUCT5 end)', 'HW4_REDDEST_56COMBO_PROJECT'));
exec ops.go(ops.mjoin_ra('HW4_REDDEST_56COMBO_PROJECT', 'HW4_HERO_COMBO_W_ALL_STAT', 'REFLEXES_CARD_COUNT, REFLEXES_CARD_TYPE_COUNT, HERO_COUNT', 'REFLEXES_CARD_COUNT, REFLEXES_CARD_TYPE_COUNT, HERO_COUNT', 'HW4_REDDEST_ALL_COMBO'));

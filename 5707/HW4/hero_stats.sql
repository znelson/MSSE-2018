DECLARE
BEGIN
ops.go(
ops.mjoin_ra(
	'HW4_HERO_COMBO_MEMB_WNAME',
	'HERO_CARD',
	'HERO_NAME',
	'HERO',
	'HW4_HERO_COMBO_CARD_PAIR'));
END;
/

DECLARE
BEGIN
ops.go(
ops.group_ra(
	'HW4_HERO_COMBO_CARD_PAIR', 
	'ID', 
	'RANGED_CARD_TYPE_COUNT = count(case when class = ''Ranged'' then 1 else null end), 
STRENGTH_CARD_TYPE_COUNT = count(case when class = ''Strength'' then 1 else null end), 
REFLEXES_CARD_TYPE_COUNT = count(case when class = ''Reflexes'' then 1 else null end), 
INTUITION_CARD_TYPE_COUNT = count(case when class = ''Intuition'' then 1 else null end), 
TECH_CARD_TYPE_COUNT = count(case when class = ''Tech'' then 1 else null end), 
RANGED_CARD_COUNT = sum(case when class = ''Ranged'' then COUNT else 0 end), 
STRENGTH_CARD_COUNT = sum(case when class = ''Strength'' then COUNT else 0 end), 
REFLEXES_CARD_COUNT = sum(case when class = ''Reflexes'' then COUNT else 0 end), 
INTUITION_CARD_COUNT = sum(case when class = ''Intuition'' then COUNT else 0 end), 
TECH_CARD_COUNT = sum(case when class = ''Tech'' then COUNT else 0 end)', 
	'HW4_HERO_COMBO_ID_W_CLASS_STAT'));
END;
/

DECLARE
BEGIN
ops.go(
ops.group_ra(
	'HW4_HERO_COMBO_MEMB_WNAME',
	'ID',
	'HERO_COUNT = count(*), 
MALE_HERO_COUNT = count(case when HERO_GENDER = ''Male'' then 1 else null end), 
FEMALE_HERO_COUNT = count(case when HERO_GENDER = ''Female'' then 1 else null end)', 
	'HW4_HERO_COMBO_ID_W_HERO_STAT'));
END;
/

DECLARE
BEGIN
ops.go(
ops.mjoin_ra(
	'HW4_HERO_COMBO_ID_W_CLASS_STAT',
	'HW4_HERO_COMBO_ID_W_HERO_STAT',
	'ID',
	'ID',
	'HW4_HERO_COMBO_W_ALL_STAT'));
END;
/

DECLARE
BEGIN
ops.go(
ops.group_ra(
	'HW4_HERO_COMBO_CARD_PAIR',
	'ID', 
	'XMEN_CARD_TYPE_COUNT = count(case when team = ''X-Men'' then 1 else null end), 
AVENGERS_CARD_TYPE_COUNT = count(case when team = ''Avengers'' then 1 else null end), 
SPIDERFRIENDS_CARD_TYPE_COUNT = count(case when team = ''Spider-Friends'' then 1 else null end), 
SHIELD_CARD_TYPE_COUNT = count(case when team = ''Shield'' then 1 else null end), 
TEAMLESS_CARD_TYPE_COUNT = count(case when team = null then 1 else null end), 
RANGED_CARD_TYPE_COUNT = count(case when class = ''Ranged'' then 1 else null end), 
STRENGTH_CARD_TYPE_COUNT = count(case when class = ''Strength'' then 1 else null end), 
REFLEXES_CARD_TYPE_COUNT = count(case when class = ''Reflexes'' then 1 else null end), 
INTUITION_CARD_TYPE_COUNT = count(case when class = ''Intuition'' then 1 else null end), 
TECH_CARD_TYPE_COUNT = count(case when class = ''Tech'' then 1 else null end), 
RANGED_CARD_COUNT = sum(case when class = ''Ranged'' then COUNT else 0 end), 
STRENGTH_CARD_COUNT = sum(case when class = ''Strength'' then COUNT else 0 end), 
REFLEXES_CARD_COUNT = sum(case when class = ''Reflexes'' then COUNT else 0 end), 
INTUITION_CARD_COUNT = sum(case when class = ''Intuition'' then COUNT else 0 end), 
TECH_CARD_COUNT = sum(case when class = ''Tech'' then COUNT else 0 end)', 
	'HW4_HERO_COMBO_ID_W_CLASS_STAT'));
END;
/





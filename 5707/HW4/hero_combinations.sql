
--exec ops.go(ops.reduce_ra('HERO', 'H1_HERO_NAME=HERO_NAME', 'HW4_HERO1'));
--exec ops.go(ops.reduce_ra('HERO', 'H2_HERO_NAME=HERO_NAME', 'HW4_HERO2'));
--exec ops.go(ops.reduce_ra('HERO', 'H3_HERO_NAME=HERO_NAME', 'HW4_HERO3'));
--exec ops.go(ops.reduce_ra('HERO', 'H4_HERO_NAME=HERO_NAME', 'HW4_HERO4'));
--exec ops.go(ops.reduce_ra('HERO', 'H5_HERO_NAME=HERO_NAME', 'HW4_HERO5'));
--exec ops.go(ops.reduce_ra('HERO', 'H6_HERO_NAME=HERO_NAME', 'HW4_HERO6'));

--exec ops.go(ops.times_ra('HW4_HERO1', 'HW4_HERO2', 'HW4_HERO_2_TUPLE'));
--exec ops.go(ops.times_ra('HW4_HERO_2_TUPLE', 'HW4_HERO3', 'HW4_HERO_3_TUPLE'));
--exec ops.go(ops.times_ra('HW4_HERO_3_TUPLE', 'HW4_HERO4', 'HW4_HERO_4_TUPLE'));
--exec ops.go(ops.times_ra('HW4_HERO_4_TUPLE', 'HW4_HERO5', 'HW4_HERO_5_TUPLE'));
--exec ops.go(ops.times_ra('HW4_HERO_5_TUPLE', 'HW4_HERO6', 'HW4_HERO_6_TUPLE'));

--exec ops.go(ops.filter_ra('HW4_HERO_5_TUPLE', 'H1_HERO_NAME<H2_HERO_NAME and H2_HERO_NAME<H3_HERO_NAME and H3_HERO_NAME<H4_HERO_NAME and H4_HERO_NAME<H5_HERO_NAME', 'HW4_HERO_5_TUPLE_UNORDERED'));
--exec ops.go(ops.filter_ra('HW4_HERO_6_TUPLE', 'H1_HERO_NAME<H2_HERO_NAME and H2_HERO_NAME<H3_HERO_NAME and H3_HERO_NAME<H4_HERO_NAME and H4_HERO_NAME<H5_HERO_NAME and H5_HERO_NAME<H6_HERO_NAME', 'HW4_HERO_6_TUPLE_UNORDERED'));

SELECT COUNT(*) FROM HW4_HERO_6_TUPLE_UNORDERED;
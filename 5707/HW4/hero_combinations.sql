--drop table HW4_HERO1;
--drop table HW4_HERO2;
--drop table HW4_HERO3;
--drop table HW4_HERO4;
--drop table HW4_HERO5;
--drop table HW4_HERO6;

--exec ops.go(ops.reduce_ra('HERO', 'H1_HERO_ID=HERO_ID', 'H1_HERO_NAME=HERO_NAME', 'HW4_HERO1'));
--exec ops.go(ops.reduce_ra('HERO', 'H2_HERO_ID=HERO_ID', 'H2_HERO_NAME=HERO_NAME', 'HW4_HERO2'));
--exec ops.go(ops.reduce_ra('HERO', 'H3_HERO_ID=HERO_ID', 'H3_HERO_NAME=HERO_NAME', 'HW4_HERO3'));
--exec ops.go(ops.reduce_ra('HERO', 'H4_HERO_ID=HERO_ID', 'H4_HERO_NAME=HERO_NAME', 'HW4_HERO4'));
--exec ops.go(ops.reduce_ra('HERO', 'H5_HERO_ID=HERO_ID', 'H5_HERO_NAME=HERO_NAME', 'HW4_HERO5'));
--exec ops.go(ops.reduce_ra('HERO', 'H6_HERO_ID=HERO_ID', 'H6_HERO_NAME=HERO_NAME', 'HW4_HERO6'));

--drop table HW4_HERO_2_TUPLE;
--drop table HW4_HERO_3_TUPLE;
--drop table HW4_HERO_4_TUPLE;
--drop table HW4_HERO_5_TUPLE;
--drop table HW4_HERO_6_TUPLE;
--drop table HW4_HERO_2_TUPLE_U;
--drop table HW4_HERO_3_TUPLE_U;
--drop table HW4_HERO_4_TUPLE_U;
--drop table HW4_HERO_5_TUPLE_U;
--drop table HW4_HERO_6_TUPLE_U;
--
--exec ops.go(ops.times_ra('HW4_HERO1', 'HW4_HERO2', 'HW4_HERO_2_TUPLE'));
--exec ops.go(ops.filter_ra('HW4_HERO_2_TUPLE', 'H1_HERO_ID<H2_HERO_ID', 'HW4_HERO_2_TUPLE_U'));
--
--exec ops.go(ops.times_ra('HW4_HERO_2_TUPLE_U', 'HW4_HERO3', 'HW4_HERO_3_TUPLE'));
--exec ops.go(ops.filter_ra('HW4_HERO_3_TUPLE', 'H2_HERO_ID<H3_HERO_ID', 'HW4_HERO_3_TUPLE_U'));
--
--exec ops.go(ops.times_ra('HW4_HERO_3_TUPLE_U', 'HW4_HERO4', 'HW4_HERO_4_TUPLE'));
--exec ops.go(ops.filter_ra('HW4_HERO_4_TUPLE', 'H3_HERO_ID<H4_HERO_ID', 'HW4_HERO_4_TUPLE_U'));
--
--exec ops.go(ops.times_ra('HW4_HERO_4_TUPLE_U', 'HW4_HERO5', 'HW4_HERO_5_TUPLE'));
--exec ops.go(ops.filter_ra('HW4_HERO_5_TUPLE', 'H4_HERO_ID<H5_HERO_ID', 'HW4_HERO_5_TUPLE_U'));
--
--SELECT COUNT(*) from HW4_HERO_5_TUPLE_U;
--
--exec ops.go(ops.times_ra('HW4_HERO_5_TUPLE_U', 'HW4_HERO6', 'HW4_HERO_6_TUPLE'));
--exec ops.go(ops.filter_ra('HW4_HERO_6_TUPLE', 'H5_HERO_ID<H6_HERO_ID', 'HW4_HERO_6_TUPLE_U'));
--
--SELECT COUNT(*) from HW4_HERO_6_TUPLE_U;

--exec ops.go(ops.reduce_ra('HW4_HERO_5_TUPLE_U', 'ID=H1_HERO_ID||H2_HERO_ID||H3_HERO_ID||H4_HERO_ID||H5_HERO_ID||'' ''', ops.allcols('HW4_HERO_5_TUPLE_U'), 'HW4_HERO_5_TUPLE_U_ARBID'));
--exec ops.go(ops.reduce_ra('HW4_HERO_6_TUPLE_U', 'ID=H1_HERO_ID||H2_HERO_ID||H3_HERO_ID||H4_HERO_ID||H5_HERO_ID||H6_HERO_ID', ops.allcols('HW4_HERO_6_TUPLE_U'), 'HW4_HERO_6_TUPLE_U_ARBID'));

--drop table HW4_HERO_5COMBO_H1;
--drop table HW4_HERO_5COMBO_H2;
--drop table HW4_HERO_5COMBO_H3;
--drop table HW4_HERO_5COMBO_H4;
--drop table HW4_HERO_5COMBO_H5;
--drop table HW4_HERO_6COMBO_H1;
--drop table HW4_HERO_6COMBO_H2;
--drop table HW4_HERO_6COMBO_H3;
--drop table HW4_HERO_6COMBO_H4;
--drop table HW4_HERO_6COMBO_H5;
--drop table HW4_HERO_6COMBO_H6;

--exec ops.go(ops.reduce_ra('HW4_HERO_5_TUPLE_U_ARBID', 'ID,HERO_ID=H1_HERO_ID', 'HW4_HERO_5COMBO_H1'));
--exec ops.go(ops.reduce_ra('HW4_HERO_5_TUPLE_U_ARBID', 'ID,HERO_ID=H2_HERO_ID', 'HW4_HERO_5COMBO_H2'));
--exec ops.go(ops.reduce_ra('HW4_HERO_5_TUPLE_U_ARBID', 'ID,HERO_ID=H3_HERO_ID', 'HW4_HERO_5COMBO_H3'));
--exec ops.go(ops.reduce_ra('HW4_HERO_5_TUPLE_U_ARBID', 'ID,HERO_ID=H4_HERO_ID', 'HW4_HERO_5COMBO_H4'));
--exec ops.go(ops.reduce_ra('HW4_HERO_5_TUPLE_U_ARBID', 'ID,HERO_ID=H5_HERO_ID', 'HW4_HERO_5COMBO_H5'));

--exec ops.go(ops.reduce_ra('HW4_HERO_6_TUPLE_U_ARBID', 'ID,HERO_ID=H1_HERO_ID', 'HW4_HERO_6COMBO_H1'));
--exec ops.go(ops.reduce_ra('HW4_HERO_6_TUPLE_U_ARBID', 'ID,HERO_ID=H2_HERO_ID', 'HW4_HERO_6COMBO_H2'));
--exec ops.go(ops.reduce_ra('HW4_HERO_6_TUPLE_U_ARBID', 'ID,HERO_ID=H3_HERO_ID', 'HW4_HERO_6COMBO_H3'));
--exec ops.go(ops.reduce_ra('HW4_HERO_6_TUPLE_U_ARBID', 'ID,HERO_ID=H4_HERO_ID', 'HW4_HERO_6COMBO_H4'));
--exec ops.go(ops.reduce_ra('HW4_HERO_6_TUPLE_U_ARBID', 'ID,HERO_ID=H5_HERO_ID', 'HW4_HERO_6COMBO_H5'));
--exec ops.go(ops.reduce_ra('HW4_HERO_6_TUPLE_U_ARBID', 'ID,HERO_ID=H6_HERO_ID', 'HW4_HERO_6COMBO_H6'));

--exec ops.go(ops.union_ra('HW4_HERO_5COMBO_H1', 'HW4_HERO_5COMBO_H2', 'HW4_HERO_5COMBO_H12'));
--exec ops.go(ops.union_ra('HW4_HERO_5COMBO_H12', 'HW4_HERO_5COMBO_H3', 'HW4_HERO_5COMBO_H123'));
--exec ops.go(ops.union_ra('HW4_HERO_5COMBO_H123', 'HW4_HERO_5COMBO_H4', 'HW4_HERO_5COMBO_H1234'));
--exec ops.go(ops.union_ra('HW4_HERO_5COMBO_H1234', 'HW4_HERO_5COMBO_H5', 'HW4_HERO_5COMBO_H12345'));

--exec ops.go(ops.union_ra('HW4_HERO_6COMBO_H1', 'HW4_HERO_6COMBO_H2', 'HW4_HERO_6COMBO_H12'));
--exec ops.go(ops.union_ra('HW4_HERO_6COMBO_H12', 'HW4_HERO_6COMBO_H3', 'HW4_HERO_6COMBO_H123'));
--exec ops.go(ops.union_ra('HW4_HERO_6COMBO_H123', 'HW4_HERO_6COMBO_H4', 'HW4_HERO_6COMBO_H1234'));
--exec ops.go(ops.union_ra('HW4_HERO_6COMBO_H1234', 'HW4_HERO_6COMBO_H5', 'HW4_HERO_6COMBO_H12345'));
--exec ops.go(ops.union_ra('HW4_HERO_6COMBO_H12345', 'HW4_HERO_6COMBO_H6', 'HW4_HERO_6COMBO_H123456'));

exec ops.go(ops.union_ra('HW4_HERO_6COMBO_H123456', 'HW4_HERO_5COMBO_H12345', 'HW4_HERO_COMBO_MEMBERSHIP'));
exec ops.go(ops.mjoin_ra('HW4_HERO_COMBO_MEMBERSHIP', 'HERO', 'HERO_ID', 'HERO_ID', 'HW4_HERO_COMBO_MEMB_WNAME'));

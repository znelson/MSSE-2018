--Which team has a higher average attack value, Avengers or X-men?
/**
drop table JTEST_TEMP1;
drop table JTest_Team_Avg_Attack;
exec ops.go(ops.filter_ra('HERO_CARD','TEAM is not null','JTEST_TEMP1'));
exec ops.go(ops.group_ra('JTEST_TEMP1','TEAM','Avg_Attack=avg(ATTACK)','JTest_Team_Avg_Attack'));
/**/


--Which class is cheaper in general?
/**
drop table JTest_Class_Avg_COST;
exec ops.go(ops.group_ra('HERO_CARD','CLASS','Avg_COST=avg(COST)','JTest_Class_Avg_COST'));
/**/


--Find each female hero who belongs to at least Ranged and Reflexes classes
/**
drop table JTEST_HERO_CARD_W_GENDER;
drop table JTEST_HERO_CARD_FEMALE;
drop table JTEST_HERO_CARD_FEMALE_RR;
drop table JTEST_TEMP2;
drop table JTEST_TEMP3;
drop table JTEST_FEMALE_HERO_CHAR_RR;
exec ops.go(ops.mjoin_ra('HERO_CARD','HERO','HERO','HERO_NAME','JTEST_HERO_CARD_W_GENDER'));
exec ops.go(ops.filter_ra('JTEST_HERO_CARD_W_GENDER','HERO_GENDER=''Female''','JTEST_HERO_CARD_FEMALE'));
exec ops.go(ops.filter_ra('JTEST_HERO_CARD_FEMALE','CLASS=''Ranged'' or CLASS=''Reflexes''','JTEST_HERO_CARD_FEMALE_RR'));
exec ops.go(ops.group_ra('JTEST_HERO_CARD_FEMALE_RR','HERO','CLASS_COUNT=count(DISTINCT CLASS)','JTEST_TEMP2'));
exec ops.go(ops.filter_ra('JTEST_TEMP2','CLASS_COUNT=2','JTEST_TEMP3'));
exec ops.go(ops.reduce_ra('JTEST_TEMP3','HERO','JTEST_FEMALE_HERO_CHAR_RR'));
/**/


--Find each pair of male and female hero who are from different team but same class
/**
exec ops.go(ops.mjoin_ra('HERO_CARD','HERO','HERO','HERO_NAME','JTEST_HERO_CARD_W_GENDER'));
exec ops.go(ops.filter_ra('JTEST_HERO_CARD_W_GENDER','HERO_GENDER=''Male''','JTEST_HERO_MALE'));
exec ops.go(ops.filter_ra('JTEST_HERO_CARD_W_GENDER','HERO_GENDER=''Female''','JTEST_HERO_FEMALE'));
exec ops.go(ops.times_ra('JTEST_HERO_MALE','JTEST_HERO_FEMALE','JTEST_HERO_GENDERMIX_PAIR'));
exec ops.go(ops.filter_ra('JTEST_HERO_GENDERMIX_PAIR','JTEST_HERO_MALE_TEAM!=JTEST_HERO_FEMALE_TEAM and JTEST_HERO_MALE_CLASS=JTEST_HERO_FEMALE_CLASS','JTEST_HERO_MF_TC'));
--exec ops.go(ops.project_ra('JTEST_HERO_MF_TC','JTEST_HERO_MALE_HERO,JTEST_HERO_MALE_TEAM,JTEST_HERO_MALE_CLASS,JTEST_HERO_FEMALE_HERO,JTEST_HERO_FEMALE_TEAM,JTEST_HERO_FEMALE_CLASS,JTEST_HERO_MALE_NAME,JTEST_HERO_FEMALE_NAME','JTEST_HERO_MF_TC_FINAL'));
exec ops.go(ops.reduce_ra('JTEST_HERO_MF_TC','JTEST_HERO_MALE_HERO,JTEST_HERO_MALE_TEAM,JTEST_HERO_MALE_CLASS,JTEST_HERO_FEMALE_HERO,JTEST_HERO_FEMALE_TEAM,JTEST_HERO_FEMALE_CLASS','JTEST_HERO_MF_TC_FINAL'));
/**/


--Find the most expensive combination of heros(not hero cards) that covers all the colors/classes
--Which team has a higher average attack value, Avengers or X-men?
/**
drop table JTEST_TEMP1;
drop table JTest_Team_Avg_Attack;
exec ops.go(ops.filter_ra('HERO_CARD','TEAM is not null','JTEST_TEMP1'));
exec ops.go(ops.group_ra('JTEST_TEMP1','TEAM','Avg_Attack=avg(ATTACK)','JTest_Team_Avg_Attack'));
/**/
--Which class is cheapest in general?
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
--Suppose you have 3 cards in hand. You want to use all of them to recruite from the rest of the cards. Find each set of three cards that would make it possible 
--for you to recruite at least one card from each class.
/**
drop table JTEST_HERO_CARD_STRENGTH;
drop table JTEST_HERO_CARD_REFLEXES;
drop table JTEST_HERO_CARD_RANGED;
drop table JTEST_HERO_CARD_INTUITION;
drop table JTEST_HERO_CARD_TECH;
drop table JTEST_HERO_CARD_STRENGTH1;
drop table JTEST_HERO_CARD_REFLEXES1;
drop table JTEST_HERO_CARD_RANGED1;
drop table JTEST_HERO_CARD_INTUITION1;
drop table JTEST_HERO_CARD_TECH1;
drop table JTEST_HERO_CARD_SR;
drop table JTEST_HERO_CARD_SRR;
drop table JTEST_HERO_CARD_SRRI;
drop table JTEST_HERO_CARD_CLASS_MIX;
drop table JTEST_HERO_CARD_CLASS_MIX1;


exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Strength''','JTEST_HERO_CARD_STRENGTH'));
exec ops.go(ops.reduce_ra('JTEST_HERO_CARD_STRENGTH','NAME1=NAME','COST1=COST,CLASS1=CLASS','JTEST_HERO_CARD_STRENGTH1'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Reflexes''','JTEST_HERO_CARD_REFLEXES'));
exec ops.go(ops.reduce_ra('JTEST_HERO_CARD_REFLEXES','NAME2=NAME','COST2=COST,CLASS2=CLASS','JTEST_HERO_CARD_REFLEXES1'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Ranged''','JTEST_HERO_CARD_RANGED'));
exec ops.go(ops.reduce_ra('JTEST_HERO_CARD_RANGED','NAME3=NAME','COST3=COST,CLASS3=CLASS','JTEST_HERO_CARD_RANGED1'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Intuition''','JTEST_HERO_CARD_INTUITION'));
exec ops.go(ops.reduce_ra('JTEST_HERO_CARD_INTUITION','NAME4=NAME','COST4=COST,CLASS4=CLASS','JTEST_HERO_CARD_INTUITION1'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Tech''','JTEST_HERO_CARD_TECH'));
exec ops.go(ops.reduce_ra('JTEST_HERO_CARD_TECH','NAME5=NAME','COST5=COST,CLASS5=CLASS','JTEST_HERO_CARD_TECH1'));
exec ops.go(ops.times_ra('JTEST_HERO_CARD_STRENGTH1','JTEST_HERO_CARD_REFLEXES1','JTEST_HERO_CARD_SR'));
exec ops.go(ops.times_ra('JTEST_HERO_CARD_SR','JTEST_HERO_CARD_RANGED1','JTEST_HERO_CARD_SRR'));
exec ops.go(ops.times_ra('JTEST_HERO_CARD_SRR','JTEST_HERO_CARD_INTUITION1','JTEST_HERO_CARD_SRRI'));
exec ops.go(ops.times_ra('JTEST_HERO_CARD_SRRI','JTEST_HERO_CARD_TECH1','JTEST_HERO_CARD_CLASS_MIX'));
exec ops.go(ops.project_ra('JTEST_HERO_CARD_CLASS_MIX','NAME1,CLASS1,NAME2,CLASS2,NAME3,CLASS3,NAME4,CLASS4,NAME5,CLASS5,COST=COST1+COST2+COST3+COST4+COST5','JTEST_HERO_CARD_CLASS_MIX1'));

drop table JTEST_HAND_CARD_WRECRUIT;
drop table JTEST_HAND_CARD_WRECRUIT1;
drop table JTEST_HAND_CARD_WRECRUIT2;
drop table JTEST_HAND_CARD_WRECRUIT3;
drop table JTEST_HAND_CARD_WRECRUIT_H12;
drop table JTEST_HAND_CARD_WRECRUIT_H123;
drop table JTEST_HAND_CARD_TOTAL_RECRUIT;

exec ops.go(ops.filter_ra('HERO_CARD','RECRUIT is not null','JTEST_HAND_CARD_WRECRUIT'));
exec ops.go(ops.reduce_ra('JTEST_HAND_CARD_WRECRUIT','HAND_CARD_NAME1=NAME','RECRUIT1=RECRUIT','JTEST_HAND_CARD_WRECRUIT1'));
exec ops.go(ops.reduce_ra('JTEST_HAND_CARD_WRECRUIT','HAND_CARD_NAME2=NAME','RECRUIT2=RECRUIT','JTEST_HAND_CARD_WRECRUIT2'));
exec ops.go(ops.reduce_ra('JTEST_HAND_CARD_WRECRUIT','HAND_CARD_NAME3=NAME','RECRUIT3=RECRUIT','JTEST_HAND_CARD_WRECRUIT3'));
exec ops.go(ops.cjoin_ra('JTEST_HAND_CARD_WRECRUIT1','JTEST_HAND_CARD_WRECRUIT2','HAND_CARD_NAME1<HAND_CARD_NAME2','JTEST_HAND_CARD_WRECRUIT_H12'));
exec ops.go(ops.cjoin_ra('JTEST_HAND_CARD_WRECRUIT_H12','JTEST_HAND_CARD_WRECRUIT3','HAND_CARD_NAME2<HAND_CARD_NAME3','JTEST_HAND_CARD_WRECRUIT_H123'));
exec ops.go(ops.project_ra('JTEST_HAND_CARD_WRECRUIT_H123','HAND_CARD_NAME1,HAND_CARD_NAME2,HAND_CARD_NAME3,RECRUIT=RECRUIT1+RECRUIT2+RECRUIT3','JTEST_HAND_CARD_TOTAL_RECRUIT'));
exec ops.go(ops.cjoin_ra('JTEST_HAND_CARD_TOTAL_RECRUIT','JTEST_HERO_CARD_CLASS_MIX1','RECRUIT>=COST and HAND_CARD_NAME1 not in (NAME1,NAME2,NAME3,NAME4,NAME5) and HAND_CARD_NAME2 not in (NAME1,NAME2,NAME3,NAME4,NAME5) and HAND_CARD_NAME3 not in (NAME1,NAME2,NAME3,NAME4,NAME5)','JTEST_RESULT'));
/**/

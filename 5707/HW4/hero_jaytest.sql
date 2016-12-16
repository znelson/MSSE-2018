--Which team has the highest average attack value, Avengers, X-men, Shiled or Spider-Friends? (Ignore the cards with a "Null" in ATTACK)
exec ops.go(ops.filter_ra('HERO_CARD','TEAM is not null','HW4_HERO_CARD_W_TEAM'));
exec ops.go(ops.group_ra('HW4_HERO_CARD_W_TEAM','TEAM','Avg_Attack=avg(ATTACK)','HW4_Team_Avg_Attack'));

--Which class is cheapest in general?(Ignore the cards with a "Null" in COST)
exec ops.go(ops.group_ra('HERO_CARD','CLASS','Avg_COST=avg(COST)','HW4_Class_Avg_COST'));

--Find each pair of male and female hero who are from different teams but same class
exec ops.go(ops.mjoin_ra('HERO_CARD','HERO','HERO','HERO_NAME','HW4_HERO_CARD_W_GENDER'));
exec ops.go(ops.filter_ra('HW4_HERO_CARD_W_GENDER','HERO_GENDER=''Male''','HW4_HERO_CARD_MALE'));
exec ops.go(ops.filter_ra('HW4_HERO_CARD_W_GENDER','HERO_GENDER=''Female''','HW4_HERO_CARD_FEMALE'));
exec ops.go(ops.times_ra('HW4_HERO_CARD_MALE','HW4_HERO_CARD_FEMALE','HW4_HERO_CARD_GENDERMIX_PAIR'));
exec ops.go(ops.filter_ra('HW4_HERO_CARD_GENDERMIX_PAIR','HW4_HERO_CARD_MALE_TEAM!=HW4_HERO_CARD_FEMALE_TEAM and HW4_HERO_CARD_MALE_CLASS=HW4_HERO_CARD_FEMALE_CLASS','HW4_HERO_CARD_GEN_CLA_TEAM'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_GEN_CLA_TEAM','MALE_HERO=HW4_HERO_CARD_MALE_HERO,MALE_HERO_TEAM=HW4_HERO_CARD_MALE_TEAM,FEMALE_HERO=HW4_HERO_CARD_FEMALE_HERO,FEMALE_HERO_TEAM=HW4_HERO_CARD_FEMALE_TEAM,CLASS=HW4_HERO_CARD_FEMALE_CLASS','HW4_HERO_CARD_GEN_CLA_TEAM_RES'));

--Find each female hero who belongs to at least Ranged and Reflexes classes
exec ops.go(ops.mjoin_ra('HERO_CARD','HERO','HERO','HERO_NAME','HW4_HERO_CARD_W_GENDER'));
exec ops.go(ops.filter_ra('HW4_HERO_CARD_W_GENDER','HERO_GENDER=''Female'' and (CLASS=''Ranged'' or CLASS=''Reflexes'')','HW4_HERO_CARD_FEM_RAN_OR_REF'));
exec ops.go(ops.group_ra('HW4_HERO_CARD_FEM_RAN_OR_REF','HERO','CLASS_COUNT=count(DISTINCT CLASS)','HW4_HERO_CARD_FEM_RRCLAS_CNT'));
exec ops.go(ops.filter_ra('HW4_HERO_CARD_FEM_RRCLAS_CNT','CLASS_COUNT=2','HW4_HERO_CARD_FEM_RAN_N_REF'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_FEM_RAN_N_REF','HERO','HW4_HERO_FEM_RAN_N_REF'));

--Suppose you have 3 cards in hand. You want to use all of them to recruite from the rest of the cards. Find each set of three cards that would make it possible 
--for you to recruite at least one card from each class.
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Strength''','HW4_HERO_CARD_STR'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_STR','NAME1=NAME','COST1=COST,CLASS1=CLASS','HW4_HERO_CARD_STR_CLA_COST'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Reflexes''','HW4_HERO_CARD_REF'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_REF','NAME2=NAME','COST2=COST,CLASS2=CLASS','HW4_HERO_CARD_REF_CLA_COST'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Ranged''','HW4_HERO_CARD_RAN'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_RAN','NAME3=NAME','COST3=COST,CLASS3=CLASS','HW4_HERO_CARD_RAN_CLA_COST'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Intuition''','HW4_HERO_CARD_INT'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_INT','NAME4=NAME','COST4=COST,CLASS4=CLASS','HW4_HERO_CARD_INT_CLA_COST'));
exec ops.go(ops.filter_ra('HERO_CARD','CLASS=''Tech''','HW4_HERO_CARD_TEC'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_TEC','NAME5=NAME','COST5=COST,CLASS5=CLASS','HW4_HERO_CARD_TEC_CLA_COST'));
exec ops.go(ops.times_ra('HW4_HERO_CARD_STR_CLA_COST','HW4_HERO_CARD_REF_CLA_COST','HW4_HERO_CARD_CLASS_SR'));
exec ops.go(ops.times_ra('HW4_HERO_CARD_CLASS_SR','HW4_HERO_CARD_RAN_CLA_COST','HW4_HERO_CARD_CLASS_SRR'));
exec ops.go(ops.times_ra('HW4_HERO_CARD_CLASS_SRR','HW4_HERO_CARD_INT_CLA_COST','HW4_HERO_CARD_CLASS_SRRI'));
exec ops.go(ops.times_ra('HW4_HERO_CARD_CLASS_SRRI','HW4_HERO_CARD_TEC_CLA_COST','HW4_HERO_CARD_CLASS_SRRIT'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_CLASS_SRRIT','DECK_CARD1=NAME1,DECK_CARD2=NAME2,DECK_CARD3=NAME3,DECK_CARD4=NAME4,DECK_CARD5=NAME5','CLASS1,CLASS2,CLASS3,CLASS4,CLASS5,COST=COST1+COST2+COST3+COST4+COST5','HW4_HERO_CARD_CLASS_MIX_W_COST'));

exec ops.go(ops.filter_ra('HERO_CARD','RECRUIT is not null','HW4_HERO_CARD_W_RECRUIT'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_W_RECRUIT','HAND_CARD1=NAME','RECRUIT1=RECRUIT','HW4_HERO_CARD_W_RECRUIT1'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_W_RECRUIT','HAND_CARD2=NAME','RECRUIT2=RECRUIT','HW4_HERO_CARD_W_RECRUIT2'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_W_RECRUIT','HAND_CARD3=NAME','RECRUIT3=RECRUIT','HW4_HERO_CARD_W_RECRUIT3'));
exec ops.go(ops.cjoin_ra('HW4_HERO_CARD_W_RECRUIT1','HW4_HERO_CARD_W_RECRUIT2','HAND_CARD1<HAND_CARD2','HW4_HERO_CARD_W_RECRUIT_C12'));
exec ops.go(ops.cjoin_ra('HW4_HERO_CARD_W_RECRUIT_C12','HW4_HERO_CARD_W_RECRUIT3','HAND_CARD2<HAND_CARD3','HW4_HERO_CARD_W_RECRUIT_C123'));
exec ops.go(ops.project_ra('HW4_HERO_CARD_W_RECRUIT_C123','HAND_CARD1,HAND_CARD2,HAND_CARD3,RECRUIT=RECRUIT1+RECRUIT2+RECRUIT3','HW4_HERO_CARD_SET3_W_TOT_REC'));
exec ops.go(ops.cjoin_ra('HW4_HERO_CARD_SET3_W_TOT_REC','HW4_HERO_CARD_CLASS_MIX_W_COST','RECRUIT>=COST and HAND_CARD1 not in (DECK_CARD1,DECK_CARD2,DECK_CARD3,DECK_CARD4,DECK_CARD5) and HAND_CARD2 not in (DECK_CARD1,DECK_CARD2,DECK_CARD3,DECK_CARD4,DECK_CARD5) and HAND_CARD3 not in (DECK_CARD1,DECK_CARD2,DECK_CARD3,DECK_CARD4,DECK_CARD5)','HW4_HERO_CARD_RECRUIT_RES'));
exec ops.go(ops.reduce_ra('HW4_HERO_CARD_RECRUIT_RES','HAND_CARD1,HAND_CARD2,HAND_CARD3','HW4_HERO_CARD_BEST_RECR_SET3'));


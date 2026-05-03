/* check the row how rows in deductor dataset */
use health;

select * from deductor;
--------------------------------------------------------------------------------
/* 1.	Average Claim Amount per Provider */

SELECT provider_id,AVG(claim_amount) AS avg_claim_amount from deductor
GROUP BY provider_id; 
---------------------------------------------------------------------------------------
/* 2. Claim Approval Rate */

select(cast(sum(case when 
claim_status = 'Approved' then 1 else 0 end)as float) / count(*)) * 100
as claim_approval_rate from deductor;
-----------------------------------------------------------------------------------------

/*3.	Average Approval-to-Claim Ratio */

select avg(avg_approval) as avg_approval_to_claim_ratio from ( select
(approved_amount/claim_amount)*100 as avg_approval from deductor) as sub;

---------------------------------------------------------------------------------------
/*4. Average Days Between Service and Claim Submission */

select avg(days_between_service_and_claim) as avg_days_between_service_and_claim from deductor;
-----------------------------------------------------------------------------------------------
/* 5.	Monthly Claim Volume per Provider */

select provider_id , format(claim_submission_date,'MM') as claim_month ,
   count(*) as month_claim_volumne from deductor
   group by provider_id , format(claim_submission_date, 'MM')
   order by provider_id , claim_month;
------------------------------------------------------------------------------------------------------
/*6.	High-Volume Provider Ratio 
→ Hint: count providers flagged is_high_volume=1 vs total providers */

select count(case when is_high_volume = 1 then 1 end) /count(distinct provider_id)*100 as
high_volumne_provider_ratio from
deductor;


--------------------------------------------------------------------------------------------------------

/*7.	Claim Intensity Index 
→ Hint: average claim_intensity grouped by provider or specialty. */

select provider_specialty ,avg(claim_intensity) as avg_claim_intensity from deductor
group by provider_specialty
order by avg_claim_intensity desc;
---------------------------------------------------------------------------------------------------
select * from deductor;
-- 8.	Fraudulent Claim Rate 
-- → Hint: ratio of is_fraud=1 claims to total claims.

select  count(case when is_fraud = 1 then 1 end )*1.0 /count(*) as fradulent_claim_rate from deductor;

---------------------------------------------------------------------------------------------
--9.	Average Length of Stay per Visit Type 
-- → Hint: group by visit_type, then average length_of_stay.
select  * from deductor;
select visit_type, avg(length_of_stay) as avg_lenght_of_stay from deductor
group by visit_type
order by avg_lenght_of_stay desc ;
--------------------------------------------------------------------------------------------
-- 11.	Repeat Patient Visit Rate (12m) 
--→ Hint: average prior_visits_12m per patient.

select  provider_specialty , avg(prior_visits_12m) as avg_prior_visit_12m from deductor
group by provider_specialty
order by avg_prior_visit_12m desc;
-------------------------------------------------------------------------------------------
-- 12.	Claim Status Distribution 
--→ Hint: percentage breakdown of each claim_status.

select claim_status ,count(*) *100.0 /(select count(*) from deductor) as percentage_claim
from deductor 
group by claim_status 
order by percentage_claim desc ;
-------------------------------------------------------------------------------------------
--13.	Billing Gap Ratio 
-- → Hint: divide billing_gap by claim_amount.
select  sum(billing_gap) / sum(claim_amount) as billing_gap_ratio from deductor;
------------------------------------------------------------------------------------------
--14.	Top 5 Diagnosis Codes by Claim Volume 
-- → Hint: group by diagnosis_code, order by count, limit 5.

select top 5 diagnosis_code , count(claim_amount) as count_of_claim_volumne from deductor 
group by diagnosis_code
order by count_of_claim_volumne desc;
--------------------------------------------------------------------------------------------
--15. Provider Specialty Efficiency 
--→ Hint: ratio of approved_amount to claim_amount grouped by provider_specialty.

 select provider_specialty, sum(approved_amount)* 1.0 /sum(claim_amount) as efficiency_ratio
 from deductor
 group by provider_specialty;

 ------------------------------------------------------------------------------------------------

 select * from deductor;
 --------------------------------------------------------------------------------------------
 ---- total count & sum of insurance claim submitted by insurance type

 select insurance_type , count(claim_amount) as count_of_claim_submitted ,
 sum(claim_amount) as total_claim_amount from deductor 
 group by insurance_type
 order by count_of_claim_submitted desc;
------------------------------------------------------------------------------------------------
--- total claim amount submit per gender
select patient_gender , count(claim_id) as count_of_claim_id  from deductor
group by patient_gender
order by count_of_claim_id desc;
--------------------------------------------------------------------------------------------------
-- total number of claim submitted patient_state

select patient_state ,patient_gender ,count(claim_id) as count_of_claimid from deductor
group by patient_state ,patient_gender 
order by count_of_claimid desc;

-----------------------------------------------------------------------------------------------
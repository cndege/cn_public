-- Acceptance_Rate_by_Date
-- C. Ndege
-- 1/28/2022

with sent_actions as (

    select * from fb_friend_requests
    where action = 'sent'
    
), accepted_actions as (

    --validated and checked no dups
    select * from fb_friend_requests
    where action = 'accepted'
    
), accepted_requests as (

    select 
	
        sent_actions.*,
        accepted_actions.date as accepted_at
		
    from sent_actions
    left join accepted_actions 
        on sent_actions.user_id_sender = accepted_actions.user_id_sender
        and sent_actions.user_id_receiver = accepted_actions.user_id_receiver
		
), acceptance_stats_by_date as (

    select 
	
        date,
        count(1) as total_sent_requests,
        sum(case when accepted_at is not null then 1 else 0 end) as total_accepted_requests
		
    from accepted_requests
    group by 1
)

select 

    date,
    total_accepted_requests / (total_sent_requests * 1.0) as acceptance_rate

from acceptance_stats_by_date
order by 1

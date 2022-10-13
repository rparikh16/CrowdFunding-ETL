-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
Select * from campaign 
where outcome = 'live'
order by backers_count;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
Select COUNT(cf_id),cf_id
FROM backers
GROUP BY cf_id

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT contact_id,goal,pledged,(goal-pledged) as remaining_goal_amount INTO remaining_goal_amount
FROM campaign WHERE outcome = 'live'
SELECT
	b.first_name,
	b.last_name,
	b.email,
	rg.remaining_goal_amount
INTO email_contacts_remaining_goal_amount
FROM contacts as b
INNER JOIN remaining_goal_amount as rg
ON (b.contact_id = rg.contact_id)


-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT
	b.email,
	b.first_name,
	b.last_name,
	b.cf_id,
	cd.company_name,
	cd.description,
	cd.end_date,
	rg.remaining_goal_amount
INTO email_backer_remaining_goal_amount
FROM backers as b
INNER JOIN campaign as cd
ON (b.cf_id = cd.cf_id)
INNER JOIN remaining_goal_amount as rg
ON (cd.contact_id = rg.contact_id)
ORDER BY b.last_name ASC 

-- Check the table

SELECT * FROM email_backer_remaining_goal_amount

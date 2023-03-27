
--retirement_titles
select e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
Into retirement_titles
from employees as e
left join titles as t
on t.emp_no = e.emp_no
where (e.birth_date between '1952-01-01' and '1955-12-31')
order by t.emp_no;


--unique_titles

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no;
select * from unique_titles

--retiring_titles
select count(u.title),
	u.title
INTO retiring_titles
from unique_titles as u
group by u.title 
order by count(u.title) desc;

select* from retiring_titles

--mentorship_eligibitliy
select distinct on (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
Into mentorship_eligibility
from (department_employees as d left join titles as t  on d.emp_no = t.emp_no)
	left join employees as e on e.emp_no = d.emp_no
Where d.to_date =('9999-01-01')
and (e.birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no
--additional table1 to get count of mentors by title
select count(m.title), m.title
into mentors_count
from mentorship_eligibility as m
group by m.title
order by count(m.title) desc

---additional tabl2 2 to get retiring job tiles by department

select e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
	d.dept_name
Into emp
from employees as e
left join titles as t
on t.emp_no = e.emp_no
where (e.birth_date between '1952-01-01' and '1955-12-31')
order by t.emp_no;

select * from departments
select * from department_employees

select de.emp_no,
	de.dept_no,
	d.dept_name,
	de.from_date,
	de.to_date	
into empd0
from departments as d left join department_employees as de on d.dept_no = de.dept_no
where (to_date = '9999-01-01')

select e.emp_no,
	e.dept_no,
	e.dept_name,
	em.birth_date,
	e.from_date,
	e.to_date
into empd1
from employees as em left join empd0 as e on em.emp_no = e.emp_no
where (em.birth_date between '1952-01-01'and '1955-12-31')

select * from empd1

select distinct on (e1.emp_no)
	u.title,
	e1.dept_name
into bydept
from empd1 as e1 
left join unique_titles as u on u.emp_no = e1.emp_no

select count(d.title),
	d.title,
	d.dept_name
into tibydept
from bydept as d
group by dept_name, title
order by count(d.title) desc

select * from bydept
	

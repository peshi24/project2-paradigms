# April 29th, 2:25 pm

First work session for the project. I decided to set up my enviornment and all the files that i might need. I think my goal
for this session is to kind of get an idea of what the project is going to look like.

# April 29th, 2:35pm

I have set up the github repo and the files for this project. I thought I was going to do more work, but lowkey, don't feel like it 
so i'll do it later 😅 After reading the project description, here are some notes i decided to jot down.

- plan/1 is the main function that runs
- plan/1 should unify with plan/3 (parameters: morning, evening, and night shifts)
- schedules are a list of workstation/2 (parameters: workstation, list of employees)
- plan requirements:
    - every employee must work EXACTLY one workstation for ONE shift
    - there is a minimum and maximum number of employees for the wrok station
    - schedule can't contain idle workstations (so stations with no employees)
    - there are workstations that employees might have to avoid 
    - there is also shifts that employees have to avoid
- the file contains: employee/1, workstation/3, workstation_idle/2, avoid_workstation/2, avoid_shift/2


# May 8th, 12:30 pm

The goals for this session is to set up the plan predicate and figure out how to unify two files together for the prolog. hopefully, it doesn't take too long but lets figure it out.

# May 8th, 1:07 pm

to unify the plan predicate, i comnbined made plan/3 an input of plan/1. then, i converted all the employees to a list using the findall statement as given in the project description. and then finally, i created an assign shift function, which is going to assign employees for each shift timing and each time it creates a list of the remaining employees. Since all employees must be assigned (exactly once), this is checked by making sure that the RemainingNight is an empty list. 

I think for this session, the hardest part was definitely trying to figure out what predicates i needed to create and how i was going to make sure I was meeting all the requirements. I had to search up a few things because I forgot about the uppercase and lowercase syntax in prolog 😭 but I think once I started working on it and going forward it made a lot more sense to me, it was relatively easy. The syntax is definitely more straight forward once you've written a few lines.

# May 8th, 2:16 pm

second code sesh! for this session my goal is to finish the assign shift
function and then start thinking about how to assign workstations to the employees based on all the facts provided in the input prolog file. i think i will do this by using a recursive function for the workstations. i would probably go through the list and then update the list by eliminating the worker that has been assigned. but i would also have to keep track of the assigned employees so that way i can delete them from the list after every workstation assignment. i'm also going to need a function to input the min and the max (so a unification function) and then i can apply that. i think this might require me to also create a subtract function to subtract the employees because i'm not sure prolog has a subtract function especially for lists. it has a subtract/3 function but i have to see how it works. ok lets go code, because i think this is a good thought process. 
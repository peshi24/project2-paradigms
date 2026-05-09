
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

# May 8th, 3:02 pm

ok i just finished writing up the initial draft of the assign_workstations function. i think one thing that definitely tripped me up was realizing how many parameters i probably actually needed. at first i just assumed that i only needed a few but i realized that there were things that i needed to save, and things that i needed to delete from. The easiest part of the function was definitely the validate function because all I needed to do for that one was a negation as a failure and then it made a lot of sense. i think what i'm going to do for the next session is create some test functions so i can debug the code, because i realized that i won't know if the code is working, so i might so something simple like print out the employee list. Also, I really love the element | list function. idk why, its so nice to look at and its super easy to use 😁

# May 8th, 7:57 pm

so for this session the plan is to finish up the subtract and subset functions and then test out the code. i want to be able to see if all the functions unify correctly and if i can output them correctly as well. 

# May 8th, 8:15 pm

This is a mid check-in during my third coding session. I have finished up writing the code, at least I believe so. I have created all the small functions, double checked the parameters, and the unifications. I think the hardest part about writing the subset and subtract function was trying to figure out how many base cases to consider. At the end, I considered empty list, keeping element, and throwing away the element. I think my favorite part was trying to figure out how to code the different list functions, because it was puzzling, but at the same time really intriguing. 

# May 8th, 9:09 pm

I hate debugging. This is horrendous. I should have also probably taken a look at the input and tested it, but I didn't, and I realized I was missing a few predicates in my code like the no_work, and works_at, which I am now realizing are just testing predicates, but still. UGHHHHHHHH. Ok, I think I need to take a lookover at my subset function and then add the missing query predicates and, hopefully, I will be golden. 

# May 8th, 9:35 pm

OK, well that was infuriating. The reason it wasn't working was because I had the wrong base case for generate subset, and because I had the wrong order for choose employee. At first, it was in an infinite recursion loop because I had forgot to constrain the length, and then generate_subset was not working because I had used ([], []) which only works for two empty sets but it should have been ([], _) so that you can get a subset from any remaining set 🤦‍♀️ I'm soooo done with this project. But, hey! At least I debugged that.

# May 8th, 10:45 pm

I just went over my code for the last time and double checked everything. I changed up the generate_subset function after a little bit of research on the web, to make it more efficient. I also tested it with a few other cases, and the output seems to be working, so hopefully nothing breaks when I submit it, but so far everything lokos great, and hopefully thats the case 🤞

this project was definitely really fun and frustrating to do. i really liked making a plan and going one step at a time, which is something i didn't get to do for projetc 1 because I started so late. However, for this one I started a bit earlier, and forgot to code or journal for some of the sessions in between, but it has been really great. Working through the code step by step definitely taught me a lot about the structure of prolog and its capabilities as a programming language. I think one of my favorite parts of coding this was using the negation as failure becasuse those were the easiest to set up . The one I hated the most was generate_subset and debugging because the code is so picky there. You also have to be concise with your predicates or else you are going to end up with hanging or really long execution times which is bad for the code. I also learned the important of code order, length before generation, spelling, i had mispelled remaining so many times, which meant sometimes a different varaible instance was used, and concise code. The more times I wrote generate_subset, the faster the execution got. 
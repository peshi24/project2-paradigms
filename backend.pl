
%Name: Eshitasri Punuganti
%Date: 04/29/2026 - 05/08/2026
%Purpose: create a prolog backend that will allow a user to prepare a work schedule based on the facts given

%code for project 2

% FAIL definitions

workstation_idle(_,_) :- FAIL.
avoid_workstation(_,_) :- FAIL.
avoid_shift(_,_) :- FAIL.

% main predicate PLAN
plan(plan(Morning, Evening, Night)) :-

    %make a list of all the employees
    findall(E, employee(E), employees),

    %build the morning shift
    assign_shift(morning, Employees, Morning, RemainingMorning),

    %build the evening shift
    assign_shift(evening, RemainingMorning, Evening, RemainingEvening),

    %build the night shift
    assign_shift(night, RemainingEvening, Night, RemainingNight),

    %every employee must be assigned once (so there should be an empty list leftover)
    ReaminingNight = [].


